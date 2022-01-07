require './lib/mailing/email_sender'
class EmailReminder
  def self.remind(email_sender = EmailSender)
    problems = []
    id = nil
    DataProblem.order(:person_id).each do |problem|
      id = problem.person_id if id.nil?
      if problem.person_id.equal? id
        problems.append problem
      else
        person = Person.find(id)
        send_email_if_allowed(email_sender, person, problems)
        id = problem.person_id
        problems = [problem]
      end
    end
    return if problems.empty?

    person = Person.find(id)
    send_email_if_allowed(email_sender, person, problems)
  end

  def self.send_email_if_allowed(email_sender, person, problems)
    if should_send_email(person.id)
      email_sender.send_email(person, problems)
      EmailLog.create!(email_address: person.email, last_sent: Date.current, people_id: person.id)
    else
      Rails.logger.debug "Email not sent since the last email was sent within the last 30 days."
    end
  end

  def self.should_send_email(person_id)
    emails = EmailLog.where(people_id: person_id)
    emails.empty? || (Date.current - emails.order(:last_sent).last.last_sent).to_int > 90
  end
end
