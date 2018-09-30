require 'rails_helper'

describe 'Beers Page' do
  before :each do
    @brewery = FactoryBot.create(:brewery)
    visit new_beer_path
  end

  it "creates a beer if name is nonempty" do
    puts page
    fill_in('Name', with: "Olut")
    select(@brewery.name, from: 'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.to eq(1)
  end

end
