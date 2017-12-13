require 'pry'
require 'Date'

module CommandInputParseAndValidator

  def parse_and_validate_input(input)
    input_array = input.split(' ')
    if valid_number_of_arguments?(input_array)
      ticker, date = parse(input_array)
      if valid_date?(date) # => ticker, date
        [ticker, date]
      else
        puts error_invalid_date
        [nil, nil]
      end
    else
      puts error_wrong_number_of_arguments
      [nil, nil]
    end
  end

  private

  def parse(input_array)
    [input_array.first&.downcase, input_array.last&.downcase]
  end

  def valid_number_of_arguments?(input_array)
    input_array.count == 2
  end

  def valid_date?(date)
    begin validate_date_format(date) rescue false end
  end

  def validate_date_format(date) # maybe just need this for validation. otherwise just pass it to the ruby clientö.
    date_components = date&.split('-')
    date_components[0].length == 4 &&
      date_components[1].length == 2 &&
      date_components[2].length == 2 &&
      Date.strptime(date, '%Y-%m-%d') rescue false
  end

  def error_invalid_date
    'Invalid date format. Should be YYYY-MM-DD'
  end

  def error_wrong_number_of_arguments
    'Too many or to few arguments. Use AAPL 2013-01-01'
  end
end
