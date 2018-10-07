require 'rails_helper'
include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
        sign_in(username:"TestUser", password:"Salasana1")

      expect(page).to have_content 'Succesfully logged in as'
      expect(page).to have_content 'TestUser'
    end

    it "is redirected back to signin form if wrong credentials given" do
        sign_in(username:"TestUser", password:"wrong")
  
        expect(current_path).to eq(signin_path)
        expect(page).to have_content 'Wrong username and / or password.'
      end

      it "when signed up with good credentials, is added to the system" do
        visit signup_path
        fill_in('user[username]', with:'TestUser2')
        fill_in('user[password]', with:'Pass1')
        fill_in('user[password_confirmation]', with:'Pass1')
        expect{
          click_button('Create User')
        }.to change{User.count}.by(1)
      end
    end 
end
describe "users page has favorite fields" do
    let!(:user) { FactoryBot.create :user }
    before :each do
        sign_in(username:"TestUser", password:"Salasana1")
      end
        
      it "shows favorite style" do
        style1 = FactoryBot.create :style, name: "1"
        style2 = FactoryBot.create :style, name: "2"
        style3 = FactoryBot.create :style, name: "3"
      beer1 = create_beer_with_rating_and_style({ user: user }, 20, style1)
      beer2 = create_beer_with_rating_and_style({ user: user }, 10, style1)
      beer3 = create_beer_with_rating_and_style({ user: user }, 10, style2)
      beer4 = create_beer_with_rating_and_style({ user: user }, 20, style3)
    
        visit user_path(user)
        expect(page).to have_content 'Favorite Style: 3'
      end

      it "shows favorite brewery" do
        style1 = FactoryBot.create :style, name: "1"
        style2 = FactoryBot.create :style, name: "2"
        style3 = FactoryBot.create :style, name: "3"
        beer1 = create_beer_with_rating_and_style({ user: user }, 20, style1)
        beer2 = create_beer_with_rating_and_style({ user: user }, 10, style1)
        beer3 = create_beer_with_rating_and_style({ user: user }, 10, style2)
        beer4 = create_beer_with_rating_and_style({ user: user }, 20, style3)
    
        visit user_path(user)
        expect(page).to have_content 'Favorite Brewery: TestBrewery'
      end
end