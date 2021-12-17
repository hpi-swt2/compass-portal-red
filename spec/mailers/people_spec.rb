require "rails_helper"

RSpec.describe PeopleMailer, type: :mailer do

  context 'when sending out a weekly reminder' do
    it 'sends an email when there is a data problem' do
      person = Person.create!(name: 'Name', email: 'email@example.com')
      data_problem = [ DataProblem.create(people_id: person.id, description: "some Problem") ]
      email = described_class.with(person: person, problems: data_problem).problem_reminder_email.deliver_now

      assert !ActionMailer::Base.deliveries.empty?

      assert_equal [person.email], email.to
      assert_equal "Problem with your data!", email.subject
    end
  end
end
