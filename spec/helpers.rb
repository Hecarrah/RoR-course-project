module Helpers

    def sign_in(credentials)
      visit signin_path
      fill_in('username', with:credentials[:username])
      fill_in('password', with:credentials[:password])
      click_button('Log in')
    end

    def create_beer_with_rating(object, score)
        beer = FactoryBot.create(:beer)
        FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
        beer
      end
      
      def create_beer_with_rating_and_style(object, score, style)
        beer = FactoryBot.create(:beer, style: style)
        FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
        beer
      end
      
      def create_beers_with_many_ratings(object, *scores)
        scores.each do |score|
          create_beer_with_rating(object, score)
        end
      end 

      def stub_weather
        stub_request(:get, "http://api.apixu.com/v1/current.json?key=bfa0e8f065c64682bc0171400180710%20&q=kumpula").
  with(
    headers: {
   'Accept'=>'*/*',
   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
   'User-Agent'=>'Ruby'
    }).
  to_return(status: 200, body: '{
    "location": {
        "name": "Helsinki",
        "region": "Southern Finland",
        "country": "Finland",
        "lat": 60.18,
        "lon": 24.93,
        "tz_id": "Europe/Helsinki",
        "localtime_epoch": 1538933730,
        "localtime": "2018-10-07 20:35"
    },
    "current": {
        "last_updated_epoch": 1538933410,
        "last_updated": "2018-10-07 20:30",
        "temp_c": 3.0,
        "temp_f": 37.4,
        "is_day": 0,
        "condition": {
            "text": "Partly cloudy",
            "icon": "//cdn.apixu.com/weather/64x64/night/116.png",
            "code": 1003
        },
        "wind_mph": 4.3,
        "wind_kph": 6.8,
        "wind_degree": 330,
        "wind_dir": "NNW",
        "pressure_mb": 1012.0,
        "pressure_in": 30.4,
        "precip_mm": 0.0,
        "precip_in": 0.0,
        "humidity": 93,
        "cloud": 25,
        "feelslike_c": 1.1,
        "feelslike_f": 34.1,
        "vis_km": 10.0,
        "vis_miles": 6.0
    }
}', headers: {
  "Request-Context": "appId=cid-v1:deb1a0bf-3522-4f78-b38f-04a889c6a745",
  "Access-Control-Expose-Headers": "Request-Context",
  "access-control-allow-origin": "*",
  "access-control-allow-headers": "content-type",
  "Content-Length": "637",
  "Cache-Control": "private",
  "Content-Type": "application/json; charset=utf-8",
  "Date": "Sun, 07 Oct 2018 17:35:30 GMT"
})
end
  end