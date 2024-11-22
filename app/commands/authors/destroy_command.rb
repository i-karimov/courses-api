module Authors
  class DestroyCommand
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)
      extend Dry::Initializer

    option :ex_author, reader: :private
    option :new_candidate, optional: true
    option :find_candidate_service, reader: :private, default: proc { FindCandidate.new(ex_author:) }

    def call
      found_candidate = new_candidate || (yield find_candidate_service.call)

      begin
      ActiveRecord::Base.transaction do
        yield delegate_ex_author_courses!(found_candidate)
        yield destroy_ex_author!
        yield notify_new_author(found_candidate)
      end
      Success(found_candidate)
      rescue => e
        Failure(e)
      end
    end

    private

    def delegate_ex_author_courses!(found_candidate)
      ex_author
        .courses
        .update_all(author_id: found_candidate.id)

      Success()
    end

    def destroy_ex_author!
      ex_author.destroy!

      Success()
    end

    def notify_new_author(author)
      NewCourseTransferringNotificationJob.perform_later(author.id)

      Success()
    end
  end
end
