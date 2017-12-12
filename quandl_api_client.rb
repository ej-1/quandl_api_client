require 'rest-client'
require 'pry'
require 'json'
require 'httparty'

class QuandlApiClient
  include HTTParty
  BASE_URI = 'https://www.quandl.com'

  def options(ticker, start_date)
    { query: { ticker: ticker, api_key: api_key }, start_date: start_date }
  end

  def get(ticker, start_date)
    handle_timeouts do
      options = options(ticker, start_date)
      url = "#{ BASE_URI }#{ base_path }"
      response = self.class.get(url, options)
      response.parsed_response
    end
  end

  private

    def api_key
      #ENV['QUANDL_API_KEY']
      'bpduywUhxtPxKNj_RWKx'
    end

    def base_path
      '/api/v3/datatables/WIKI/PRICES' # need to specifiy format
    end

    def handle_timeouts
      begin
        yield
      rescue Net::OpenTimeout, Net::ReadTimeout
        {} # skicka HTTPparty exception
      end
    end
end
