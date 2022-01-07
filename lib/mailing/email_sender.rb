class EmailSender
  # class that can be easily mocked
  def self.send_email(person, problems)
    PeopleMailer.with(person: person, problems: problems).problem_reminder_email.deliver_now
  end
end
