require 'rails_helper'
include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:style) { FactoryBot.create :style, name:"style_name" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery, style: style }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery, style: style }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username:"TestUser", password:"Salasana1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
  it "fails without a score" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    click_button "Create Rating"
    expect(user.ratings.count).to eq(0)
    expect(beer1.ratings.count).to eq(0)
  end

  describe "When there exists ratings" do
    it "lists the ratings and their total number" do
        visit ratings_path
        expect(page).to have_content "Number of ratings: #{Rating.count}"
        Rating.all.each do |r|
            expect(page).to have_content r
          end
       end
    it "lists users ratings on their page" do
        visit user_path(user)
        expect(page).to have_content "Ratings"
        user.ratings.each do |r|
            expect(page).to have_content r
          end
        user.ratings.each do |r|
            expect(page).to have_no_content r
          end
        end
    it "removes a rating upon deletion" do
        create_beer_with_rating({ user: user }, 20)
        visit user_path(user)
        expect{
            click_link('delete', :href => rating_path(1))
          }.to change{Rating.count}.from(1).to(0)
        end
    end
end

describe "Rating" do
    let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
    let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
    let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
    
    it "fails when user not logged in" do
        visit new_rating_path
        select('iso 3', from:'rating[beer_id]')
        click_button "Create Rating"
        expect(beer1.ratings.count).to eq(0)
      end
    end