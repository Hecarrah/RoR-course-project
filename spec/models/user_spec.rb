require 'rails_helper'
include Helpers

RSpec.describe User, type: :model do
  describe "with a proper Username" do
    let(:user){ User.create username:"TestUser" }

    it "has the username set correctly" do
      expect(user.username).to eq("TestUser")
    end

    it "is not saved without a password" do
     expect(user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
  end

  it "is saved with a proper password" do
    user = FactoryBot.create(:user)
  
    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
  end

  describe "with a valid username and password" do
    let(:user) {FactoryBot.create(:user)}
    it "has correct average rating with two ratings" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }
  
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end
  
    it "without ratings the user does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if the user has only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
    
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      beer1 = create_beer_with_rating({ user: user }, 20)
      beer2 = create_beer_with_rating({ user: user }, 50)
      beer3 = create_beer_with_rating({ user: user }, 9)
    
      expect(user.favorite_beer).to eq(beer2)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings the user does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if the user has only one rating" do
      beer = create_beer_with_rating_and_style({ user: user }, 20, "1")
    
      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest rating if several rated" do 
      beer1 = create_beer_with_rating_and_style({ user: user }, 20, "1")
      beer2 = create_beer_with_rating_and_style({ user: user }, 10, "1")
      beer3 = create_beer_with_rating_and_style({ user: user }, 10, "2")
      beer4 = create_beer_with_rating_and_style({ user: user }, 20, "3")
    
      expect(user.favorite_style).to eq("3")
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings the user does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if the user has only one rating" do
      beer = create_beer_with_rating_and_style({ user: user }, 20, "1")
    
      expect(user.favorite_brewery).to eq("TestBrewery")
    end

    it "is the one with highest rating if several rated" do
      beer1 = create_beer_with_rating_and_style({ user: user }, 20, "1")
      beer2 = create_beer_with_rating_and_style({ user: user }, 10, "1")
      beer3 = create_beer_with_rating_and_style({ user: user }, 10, "2")
      beer4 = create_beer_with_rating_and_style({ user: user }, 20, "3")
    
      expect(user.favorite_brewery).to eq("TestBrewery")
    end
  end 



it "is not saved with the password being too short" do
  user = User.create username:"TestUser", password:"Aa1", password_confirmation:"Aa1"
  expect(user.valid?).to be(false)
  expect(User.count).to eq(0)
end
it "is not saved with the password containing only letters" do
  user = User.create username:"TestUser", password:"Aaaaab", password_confirmation:"Aaaaab"
  expect(user.valid?).to be(false)
  expect(User.count).to eq(0)
end
end
