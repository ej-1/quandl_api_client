require 'spec_helper'
require './client_runner.rb'
require './quandl_api_client.rb'

describe ClientRunner do

  before do
    @client_runner = ClientRunner.new
    @api_client = QuandlApiClient.new
  end

  context 'receives valid ticker and date' do
    it 'prints ROI and max drawdown' do
      command_line_input = 'AAPL 1981-01-21'

      @client_runner.run_request(@api_client, 'get', command_line_input, 'somerecipient@fakemail.blabla')
      expect([5.005913043478261, 0.7641560309185692])
    end
  end
end
