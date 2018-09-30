require 'rails_helper'

describe "Breweries page" do
  it "doesn't have content before creating any" do
    visit breweries_path
    expect(page).to have_content 'Breweries'
    expect(page).to have_content 'Amount of breweries: 0'
  end

  describe "when breweries exist" do

    before :each do
      @breweries = ["Olvi", "Karjala", "Karhu"]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryBot.create(:brewery, name: brewery_name, year: year += 1)
      end

      visit breweries_path
    end

    it "lists the existing breweries and their total number" do
      expect(page).to have_content "Amount of breweries: #{@breweries.count}"

      @breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end
    end

    it "allows user to navigate to page of a Brewery" do
      click_link "Karjala"

      expect(page).to have_content "Karjala"
      expect(page).to have_content "Established in 1898"
    end
  end
end
