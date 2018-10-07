require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if many returned by the API, all are shown at the page" do
    names = ["Oljenkorsi", "Gurula", "AIV"]
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ),
        Place.new( name:"Gurula", id: 2 ),
        Place.new( name:"AIV", id: 3 )
      ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    names.each do | name |
      expect(page).to have_content name
    end
  end

  it "if none returned, correct error message shown" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end
