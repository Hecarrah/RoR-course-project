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
      
    factory :style do
        name { "testStyle" }
        description { "test description"}
      end

      factory :beer do
        name { "TestBeer" }
        brewery
        style
      end
    
      factory :rating do
        score { 10 }
        beer
        user
      end
    end