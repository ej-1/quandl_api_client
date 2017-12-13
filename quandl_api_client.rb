require 'rest-client'
require 'httparty'

QuandlApiClient = Class.new(StandardError)

class QuandlApiClient
  include HTTParty
  BASE_URI = 'https://www.quandl.com'

  def get(ticker, start_date)
    handle_timeouts do
      options = options(start_date)
      url = "#{ BASE_URI }#{ base_path(ticker) }"
      response = self.class.get(url, options)
      response.parsed_response
    end
  end

  private

    def options(start_date)
      { query: { api_key: api_key, start_date: start_date } }
    end

    def api_key
      ENV['QUANDL_API_KEY'].nil? ? (raise QuandlApiClient.new('missing API key')) : ENV['QUANDL_API_KEY']
    end

    def base_path(ticker)
      "/api/v3/datasets/WIKI/#{ticker.upcase}/data.json?" # used /datasets instead /datatables. Kept getting this error "You cannot use start_date column as a filter.", with the link providede in instructions.
    end

    def handle_timeouts
      begin
        yield
      rescue Net::OpenTimeout, Net::ReadTimeout
        {error: {message: 'Timout error'}} # skicka HTTPparty exception
      end
    end
end
