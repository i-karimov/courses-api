module Authors
  class FindCandidate
    include Dry::Monads[:result]
    extend Dry::Initializer

    option :ex_author

    def call
      return Failure(:no_candidate_found) unless found_candidate

      Success(found_candidate)
    end

    private

    def found_candidate
      @found_candidate ||= Author
          .where.not(id: ex_author.id)
          .order("RANDOM()")
          .limit(1)
          .first
    end
  end
end
