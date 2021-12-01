require 'rails_helper'

RSpec.describe PersonUrl, type: :model do
  let(:person_url) { FactoryBot.build(:person_url) }

  describe "creation" do

    it "factories creates a valid object" do
      expect(person_url).to be_valid
    end
    it "saves mutliple objects in the database" do
    
      expect { 
        PersonUrl.create([{ name: "Hasso P.", url: "www.hpi.de" },{ name: "Henry T.", url: "www.ht.de" }])
      }.to change { PersonUrl.count }.by(2)
    end
    it "saves one object in the database" do
    
      expect { 
        PersonUrl.create([{ name: "Hasso P.", url: "www.hpi.de" }])
      }.to change { PersonUrl.count }.by(1)
    end
    it "does not save invalid objects in the database" do
      expect { 
        PersonUrl.create([{ name: "Hasso P.", url: "www.hpi.de" }, {name: "Peter"}])
      }.to change { PersonUrl.count }.by(1)
      
    end
    it "is not valid without an url" do
      author = PersonUrl.new({  name:"Alan Turing"})
      expect(author).not_to be_valid
    end
    it "is not valid without a name" do
      author = PersonUrl.new({  url:"http://wikipedia.org/Alan_Turing"})
      expect(author).not_to be_valid
    end
end
end