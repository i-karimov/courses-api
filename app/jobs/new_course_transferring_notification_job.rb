class NewCourseTransferringNotificationJob < ApplicationJob
  queue_as :default

  def perform(author_id)
    author = Author.find(author_id)
    AuthorMailer.new_courses_transferred(author).deliver_now
  end
end