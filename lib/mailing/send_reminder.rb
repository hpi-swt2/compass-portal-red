class SendReminder
  def self.remind
    problems = []
    id = nil
    DataProblem.order(:people_id).each do |problem|
      id = problem.people_id if id.nil?
      if problem.people_id.equal? id
        problems.append problem
      else
        person = Person.find(id)
        send_email(person, problems)
        id = problem.people_id
        problems = [problem]
      end
    end
    return if problems.empty?

    person = Person.find(id)
    send_email(person, problems)
  end

  def self.send_email(person, problems)
    emails = EmailLog.where(people_id: :person.id)
    if emails.empty? || (Date.current - emails.order(:last_sent).last.last_sent).to_int > 90
      PeopleMailer.with(person: person, problems: problems).problem_reminder_email.deliver_now
      EmailLog.create!(email_address: person.email, last_sent: Date.current, people_id: person.id)
    else
      puts "Email not sent since the last email was sent within the last 30 days."
    end
  end
end
