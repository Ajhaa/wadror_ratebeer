require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "when a brewery exists" do
    before :each do
      Brewery.create name:"TestB", year: 2000
      Style.create name:"TestS", description: "Hello"
    end

    it "is saved if all fields are filled" do
      beer = Beer.create name:"Beer", brewery_id: 1, style_id: 1
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "is not saved if name is missing" do
      beer = Beer.create brewery_id: 1, style_id: 1
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not saved if style is missing" do
      beer = Beer.create name:"Beer", brewery_id: 1
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end

end
