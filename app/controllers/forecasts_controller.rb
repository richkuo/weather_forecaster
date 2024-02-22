class ForecastsController < ApplicationController
  def index
    @zip_code = params['zip_code']
    @forecast_data, @from_cache = Forecast.get_forecast(@zip_code)
  end
end
