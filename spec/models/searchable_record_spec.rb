require 'rails_helper'

RSpec.describe SearchableRecord, type: :model do
  it "throws exception when usig it" do
    expect { described_class.new }.to raise_error(NotImplementedError)
  end
end
