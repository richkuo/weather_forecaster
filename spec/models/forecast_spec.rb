require 'rails_helper'

RSpec.describe Forecast, type: :model do
  # this is to enable caching in test environment
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
  let(:cache) { Rails.cache }

  let(:zip_code) { '07733' }
  let(:initial_forecast) { Forecast.get_forecast(zip_code) }
  let(:cached_forecast) { initial_forecast[0] }

  before do
    # this is to enable caching in test environment
    allow(Rails).to receive(:cache).and_return(memory_store)

    # set the initial cached data
    Rails.cache.write("forecast_#{zip_code}", cached_forecast)
  end

  context 'when forecast is cached' do
    let(:forecast) { Forecast.get_forecast(zip_code) }

    it 'retrieves forecast from cache' do
      expect(forecast[0]).to eq cached_forecast
    end

    it 'displays cached indicator' do
      expect(forecast[1]).to eq true
    end
  end

  context 'when forecast is not cached' do
    let(:forecast) { Forecast.get_forecast(zip_code) }

    before do
      Rails.cache.delete("forecast_#{zip_code}")
    end

    it 'retrieves forecast from API' do
      expect(forecast[0]).to_not be_nil
    end

    it 'displays not cached indicator' do
      expect(forecast[1]).to eq false
    end
  end
end
