class SendReminder
  def self.remind
    problems = []
    id = nil
    person = Person.create(name: 'Hans', email: '123@web.de')
    DataProblem.create(people_id: person.id)

    DataProblem.group(:people_id).each do |problem|
      if id.nil?
        id = problem.people_id
      end
      if problem.people_id.equal? id
        problems.append problem
      else
        puts problems
        person = Person.where("id = ?", id)
        PeopleMailer.with(person: person, problems: problems).problem_reminder_email.deliver_now
        id = problem.people_id
        problems = []
      end
    end
  end
end