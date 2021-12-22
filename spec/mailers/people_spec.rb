require "rails_helper"

RSpec.describe PeopleMailer, type: :mailer do

  context 'when sending out data problem reminder emails' do
    it 'sends an email when there is a data problem conceirning a new person' do
      person = Person.create!(first_name: 'Max', last_name: 'Mustermann', email: 'email@example.com')

      data_problems = [DataProblem.create!(people_id: person.id, description: "some Problem")]
      email = described_class.with(person: person, problems: data_problems).problem_reminder_email.deliver_now

      assert !ActionMailer::Base.deliveries.empty?

      assert_equal [person.email], email.to
      assert_equal "Problem with your data!", email.subject
    end
  end
end
