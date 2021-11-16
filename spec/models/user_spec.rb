require 'rails_helper'

RSpec.describe User, type: :model do
  # Returns a User instance that's not saved
  # https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#build-strategies
  let(:user) { FactoryBot.build(:user) }

  describe "creation using a factory" do

    it "creates a valid object" do
      expect(user).to be_valid
    end

    it "sets an email" do
      expect(user.email).not_to be_blank
    end

  end
end
