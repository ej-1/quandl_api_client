require 'spec_helper'
require 'pry'
require './quandl_api_client.rb'

describe QuandlApiClient do

  before do
    @api_client = QuandlApiClient.new
  end

  context 'valid ticker and date' do
    it 'receives valid json response' do
      response = @api_client.get('AAPL', '2017-06-30')
      expect(response['dataset_data']['data'].last.first).to eq('2017-06-30')
      expect(response['dataset_data']['data'].first[4].is_a?(Float)).to eq(true)
      expect(response['dataset_data']['column_names'][4]).to eq('Close')
    end
  end

  context 'invalid ticker and valid date' do
    it 'receives json response with error message' do
      response = @api_client.get('SOMEINVALIDTICKER', '2017-06-30')
      expect(response).to eq({"quandl_error"=>{"code"=>"QECx02", "message"=>"You have submitted an incorrect Quandl code. Please check your Quandl codes and try again."}})
    end
  end

  context 'valid ticker and invalid date' do
    it 'receives json response with empty data array' do
      response = @api_client.get('AAPL', '2050-06-30')
      expect(response['dataset_data']['data']).to eq([])
      expect(response['dataset_data']['column_names'][4]).to eq('Close') # maybe not necessary
    end
  end

  context 'invalid ticker and invalid date' do
    it 'receives json response with error message' do
      response = @api_client.get('SOMEINVALIDTICKER', '2050-06-30')
      expect(response).to eq({"quandl_error"=>{"code"=>"QECx02", "message"=>"You have submitted an incorrect Quandl code. Please check your Quandl codes and try again."}})
    end
  end
end
