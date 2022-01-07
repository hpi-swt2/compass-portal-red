# Preview all emails at http://localhost:3000/rails/mailers/people

class PeoplePreview < ActionMailer::Preview
  def problem_reminder_email
    PeopleMailer.with(Person.first).problem_reminder_email
  end
end
