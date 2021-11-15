require 'English'

# https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#linting-factories
namespace :factory_bot do
  desc 'Verify that all FactoryBot factories are valid'
  task lint: :environment do
    puts "Factories: #{FactoryBot.factories.instance_variable_get('@items').keys}"
    if Rails.env.test?
      conn = ActiveRecord::Base.connection
      conn.transaction do
        # Verbose linting will include full backtraces for each error, which can be helpful for debugging
        FactoryBot.lint verbose: true
        # After calling FactoryBot.lint, you'll want to clear out the database, as records will be created.
        # The provided example uses an sql transaction and rollback to leave the database clean.
        raise ActiveRecord::Rollback
      end
    else
      system("bundle exec rake factory_bot:lint RAILS_ENV='test'")
      raise if $CHILD_STATUS.exitstatus.nonzero?
    end
  end
end