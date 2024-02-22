class Forecast < ApplicationRecord
  def self.get_forecast(zip_code)
    # init cache and check if zip code has been cached
    cache_key = "forecast_#{zip_code}"
    cached_forecast = Rails.cache.read(cache_key)

    if cached_forecast.nil?
      request_url = "http://api.openweathermap.org/data/2.5/weather?units=metric&zip=#{zip_code}&appid=#{ENV['OPENWEATHER_API_KEY']}"
      response = HTTParty.get(request_url)

      if response['cod'] == '404'
        return [nil, false]
      end

      # if retrieving data fails, aka json parse fails, return nil
      forecast_data = JSON.parse(response.body)['main'] rescue nil

      Rails.cache.write(cache_key, forecast_data, expires_in: 30.minutes)
      [forecast_data, false]
    else
      [cached_forecast, true]
    end
  end
end
