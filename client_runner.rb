require_relative 'command_input_validator'
require_relative 'quandl_api_client'
require_relative 'data_validator'
require_relative 'data_formatter'
require_relative 'max_drawdown_calculator'
require_relative 'roi_calculator'
require_relative 'notifier'
require 'action_mailer'

ActionMailer::Base.smtp_settings = {
  address:        'smtp.gmail.com',
  port:            587,
  user_name:      ENV['EMAIL'],
  password:       ENV['EMAIL_PASSWORD'],
  authentication: :login                 # :plain, :login or :cram_md5
}

class ClientRunner
  include CommandInputValidator
  include RoiCalculator
  include DataValidator

  def run_request(api_client, request_type, command_line_input, email_recipient)
    parse_input(command_line_input)
    response = send_request_to_api(api_client, request_type)
    # if resposne is ok.
    handle_response(response, email_recipient)
  end

  private

    def handle_response(response, email_recipient)
      if response['quandl_error']
        puts response['quandl_error']
      elsif valid_data_format?(response)
        roi, max_drawdown = calculate_roi_and_max_drawdown(response)
        message_components = {roi: roi, max_drawdown: max_drawdown}
        send_email_notification(email_recipient, message_components)
      else
        puts 'something probably did not go as you wanted'
      end
    end

    def send_email_notification(recipient, message_components = {})
      body = "ROI: #{message_components[:roi]} \nMax drawdown: #{message_components[:max_drawdown]}"
      message = Notifier.welcome(recipient, body)
      message.deliver_now
    end

    def parse_input(command_line_input) # => 'AAPL' '2017-08-01'
      @ticker, @date = parse_and_validate_input(command_line_input)
    end

    def send_request_to_api(api_client, request_type)
      begin
        api_client.send(request_type, @ticker, @date)
      rescue
        retry_request(api_client, request_type)
      end
    end

    def valid_data_format?(table_data)
      validate(table_data)
    end

    def calculate_roi_and_max_drawdown(json)
      if valid_data_format?(json)
        closing_prices = reformat_data(json)
        [roi(closing_prices.first, closing_prices.last), max_drawdown(closing_prices)]
      else
        'Qandl data no longer follows expected JSON format.'
      end
    end

    def reformat_data(json) # =># [{ date: 2017-01-01, close_price: 31 }]
      DataFormatter.new(json).closing_prices
    end

    def max_drawdown(date_and_close_price_data)
      MaxDrawdownCalculator.new(date_and_close_price_data).max_drawdown_percentage
    end

    def roi(initial_price, final_value)
      return_on_investment(initial_price, final_value)
    end

    def retry_request(api_client, request_type)
      3.times { api_client.send(request_type, @ticker, @date) }
    end
end
