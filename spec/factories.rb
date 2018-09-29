FactoryBot.define do
    factory :user do
      username { "TestUser" }
      password { "Salasana1" }
      password_confirmation { "Salasana1" }
    end

    factory :brewery do
        name { "TestBrewery" }
        year { 1900 } 
      end
    
      factory :beer do
        name { "TestBeer" }
        style { "TestStyle" } 
        brewery
      end
    
      factory :rating do
        score { 10 }
        beer
        user
      end
    end