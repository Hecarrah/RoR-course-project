require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )
    stub_weather

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    save_and_open_page

    expect(page).to have_content "Oljenkorsi"
  end
    it 'if multiple are returned by the API, all are shown at the page' do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ),
         Place.new( name:"Oljenkorsi2", id: 2 ),
         Place.new( name:"Oljenkorsi3", id: 3 ) ]
      )
      stub_weather
  
      visit places_path
      fill_in('city', with: 'kumpula')
      click_button "Search"
  
      expect(page).to have_content "Oljenkorsi"
      expect(page).to have_content "Oljenkorsi2"
      expect(page).to have_content "Oljenkorsi3"
  end
  it 'if none are returned by the API, it is shown that none was found' do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        []
      )
      allow(ApixuApi).to receive(:get_weather_in).with("kumpula").and_return(
        []
      )
      visit places_path
      fill_in('city', with: 'kumpula')
      click_button "Search"
      expect(page).to have_content "No locations in kumpula"
    end

end