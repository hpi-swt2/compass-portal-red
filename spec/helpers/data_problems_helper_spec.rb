require 'rails_helper'

RSpec.describe DataProblemsHelper, type: :helper do

  let(:field_email) { "email" }
  let(:field_title) { "title" }

  let!(:person) do
    build(:person)
  end

  before do
    create(:data_problem, field: field_email, person_id: person.id)
    create(:data_problem, field: field_title, person_id: person.id)
  end

  it "returns all database fields that are marked as data problems in a url query encoded string" do
    expect(helper.edit_params(person.id)).to eq("?c_form_highlight=#{field_email},#{field_title}")
  end
end
