require './client_runner'

@client_runner = ClientRunner.new
@api_client = QuandlApiClient.new
@request_type = 'get'
@email_recipient = 'erikwjonsson@gmail.com'

loop do
  command_line_input = gets.chomp # => AAPL, 2017-01-31
  @client_runner.run_request(@api_client, @request_type, command_line_input, @email_recipient)
  break if command_line_input == 'exit'
end
