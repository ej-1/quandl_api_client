require './client_runner'

@client_runner = ClientRunner.new
@api_client = QuandlApiClient.new
@request_type = 'get'

if __FILE__ == $0 # Helps prevent rspec from executing the file on require.
  loop do
    command_line_input = gets.chomp # => AAPL, 2017-01-31 # invalid date, invalid ticker etc. different formats of date.
    @client_runner.run_request(@api_client, @request_type, command_line_input)
    break if command_line_input == 'exit'
  end
end
