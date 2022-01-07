require "rails_helper"
require "./lib/mailing/email_reminder"
require "./lib/mailing/email_sender"
RSpec.describe EmailReminder, type: :mailer do

  let(:mock_sender) { class_double("EmailSender").as_stubbed_const(transfer_nested_constants: true) }
  let(:person) { FactoryBot.create :person, first_name: 'Max', last_name: 'Mustermann', email: 'email@example.com' }

  before do
    DataProblem.delete_all
  end

  context 'when sending out data problem reminder emails' do
    it 'sends an email when there is a data problem concerning a person that has not received an email recently' do
      problem = FactoryBot.create :data_problem, person_id: person.id

      allow(mock_sender).to receive(:send_email)
      described_class.remind(mock_sender)
      expect(mock_sender).to have_received(:send_email).with(person, [problem])

      logged_emails = EmailLog.where(people_id: person.id)
      assert(logged_emails.size == 1)
      assert(logged_emails[0].email_address == person.email)

    end

    it 'does not send an email when there is a problem about a person that has recently received an email recently' do
      EmailLog.create!(email_address: person.email, last_sent: Date.current, people_id: person.id)
      FactoryBot.create :data_problem, person_id: person.id
      described_class.remind(mock_sender)
      assert ActionMailer::Base.deliveries.empty?
    end
  end
end
