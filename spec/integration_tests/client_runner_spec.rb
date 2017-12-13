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
      response = @client_runner.run_request(@api_client, 'get', command_line_input, 'somerecipient@fakemail.blabla')
      expect(response.to).to eq(["somerecipient@fakemail.blabla"])
      expect(response.subject).to eq('ROI and max drawdown calculations!')
      expect(response.body.raw_source).to eq("ROI: -81.1 % \nMax drawdown: 48.1 %")
    end
  end
end
