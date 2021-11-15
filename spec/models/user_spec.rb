require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) } 

  describe "creation using a factory" do

    it "should create a valid object" do
      expect(user).to be_valid
    end

    it "should set an email" do
      expect(user.email).not_to be_blank
    end

  end
end
