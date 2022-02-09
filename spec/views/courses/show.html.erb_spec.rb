require 'rails_helper'

RSpec.describe "courses/show", type: :view do
  let(:course) { create(:course) }

  before { assign(:course, course) }

  it "renders attributes in <p>" do
    render
    expect(rendered).to have_selector('h1', text: course.name)
    expect(rendered).to match("people")
    expect(rendered).to match("room")
    expect(rendered).to match("module category")
    expect(rendered).to match("course times")
    expect(rendered).to match("exam date")
  end

  it "renders a list of people" do
    render
    course.people.each do |person|
      expect(rendered).to have_link(person.name, href: person_path(person))
    end
  end

  it "renders a link to a room" do
    render
    expect(rendered).to have_link(course.room.full_name, href: room_path(course.room))
  end

  it "renders a list of course times" do
    render
    course.course_times.each do |course_time|
      expect(rendered).to match(course_time.full_time)
    end
  end

  it "shows an image of the course if one exists" do
    render
    expect(rendered).to match(url_for(course.image))
  end

  it "shows the placeholder image if no image was linked" do
    course.image.purge
    render
    expect(rendered).to have_css("img[src*=placeholder_course]")
  end

  it "renders a link to the map page with room id as parameter" do
    render
    expect(rendered).to have_link(href: map_path(room_id: course.room.id))
  end
end
