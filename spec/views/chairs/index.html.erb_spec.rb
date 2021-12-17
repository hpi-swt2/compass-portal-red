require 'rails_helper'

RSpec.describe "chairs/index", type: :view do
  before do
    assign(:chairs, [
             Chair.create!,
             Chair.create!
           ])
  end

  it "renders a list of chairs" do
    render
  end
end
