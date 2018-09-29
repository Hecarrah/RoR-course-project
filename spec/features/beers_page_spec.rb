require 'rails_helper'

  describe "when breweries exists" do
    before :each do 
      @breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryBot.create(:brewery, name: brewery_name, year: year += 1)
      end
    end

    it "can make make a new beer" do
        visit new_beer_path
        fill_in('beer_name', with:'TestBeer')
        select("Koff", from: 'beer[brewery_id]')
        select("Weizen", from: 'beer[style]')

        expect{
            click_button "Create Beer"
          }.to change{Beer.count}.from(0).to(1)
      
          expect(Beer.count).to eq(1)
    end
  end
