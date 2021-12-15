require 'rails_helper'

RSpec.describe PeopleHelper, type: :helper do
  it "returns red (hex) if key is part of params" do
    key = "email"
    params = %w[first_name last_name email title]
    expect(helper.form_color(key, params)).to eq("#FF9999")
  end

  it "returns white (hex) if key is not part of params" do
    key = "phone"
    params = %w[first_name last_name email title]
    expect(helper.form_color(key, params)).to eq("#FFFFFF")
  end
end
