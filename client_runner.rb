require_relative 'command_input_validator'
require_relative 'quandl_api_client'
require_relative 'data_validator'
require_relative 'data_formatter'
require_relative 'max_drawdown_calculator'
require_relative 'roi_calculator'

class ClientRunner
  include CommandInputValidator
  include RoiCalculator
  include DataValidator

  def run_request(api_client, request_type, command_line_input)
    parse_input(command_line_input)
    response = send_request_to_api(api_client, request_type)
    # if resposne is ok.
    calculate_roi_and_max_drawdown(response)
  end

  private

    def parse_input(command_line_input) # => 'AAPL' '2017-08-01'
      @ticker, @date = parse_and_validate_input(command_line_input)
    end

    def send_request_to_api(api_client, request_type)
      begin
        api_client.send(request_type, @ticker, @date)
      rescue
        retry_request
      end
    end

    def valid_data_format?(table_data)
      validate(table_data)
    end

    def calculate_roi_and_max_drawdown(json)
      if valid_data_format?(json)
        data = reformat_data(json)
        [roi(data.first[:close_price], data.last[:close_price]), max_drawdown(data)]
      else
        'Qandl data no longer follows expected JSON format.'
      end
    end

    def reformat_data(json) # =># [{ date: 2017-01-01, close_price: 31 }]
      DataFormatter.new(json).date_and_closing_price
    end

    def max_drawdown(date_and_close_price_data)
      MaxDrawdownCalculator.new(date_and_close_price_data).max_draw_down_percentage
    end

    def roi(initial_price, final_value)
      return_on_investment(initial_price, final_value)
    end

    def retry_request
      3.times { send_request_to_quandl_api }
    end
end
