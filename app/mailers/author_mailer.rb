class AuthorMailer < ApplicationMailer
  def new_courses_transferred(author)
    @author = author
    mail(to: @author.email, subject: "New Courses Assigned")
  end
end
