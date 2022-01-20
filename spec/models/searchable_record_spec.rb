require 'rails_helper'

RSpec.describe SearchableRecord, type: :model do
  let(:abstract) { Class.new(described_class) }

  it "throws exception when using it" do
    expect { described_class.new }.to raise_error(NotImplementedError)
  end

  it "has no search attributes" do
    expect(abstract.searchable_attributes).to be_empty
  end
end
