class ApixuApi

      def self.get_weather_in(city)
        url = "http://api.apixu.com/v1/current.json?key=#{key} &q=#{city}"
    
        response = HTTParty.get "#{url}"
        weather = response.parsed_response["current"]
        weather
      end

  def self.key
    raise "APIXU_APIKEY env variable not defined" if ENV['APIXU_APIKEY'].nil?
  
    ENV['APIXU_APIKEY']
  end
end