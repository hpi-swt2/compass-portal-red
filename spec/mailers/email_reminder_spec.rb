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
      problem = DataProblem.create!(person_id: person.id, description: "some Problem")
      expect(mock_sender).to receive(:send_email).with(person, [problem])

      described_class.remind(mock_sender)
      logged_emails = EmailLog.where(person_id: person.id)
      assert(logged_emails.size == 1)
      assert(logged_emails[0].email_address == person.email)

    end

    it 'does not send an email when there is a data problem concerning a person that has recently received an email recently' do
      EmailLog.create!(email_address: person.email, last_sent: Date.current, people_id: person.id)
      data_problems = [DataProblem.create!(person_id: person.id, description: "some Problem")]
      expect(mock_sender).not_to receive(:send_email).with(person, data_problems)
      described_class.remind(mock_sender)

      assert ActionMailer::Base.deliveries.empty?
    end
  end
end
