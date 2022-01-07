require 'English'
require './lib/mailing/email_reminder'

# Run with `bundle exec rake compass_mailer:remind`
namespace :compass_mailer do
  desc 'Send Reminders to all people who have problems with their data'
  task remind: :environment do
    puts "reminding task started"
    EmailReminder.remind
    puts "Reminding task finished"
  end
end
