module CommandInputValidator

  def parse_and_validate_input(input)
    parse(input) # => ticker, date
  end

  private

  def parse(input)
    input_array = input.split(' ')#.(&:downcase) # if more thant two then invalid
    ticker = input_array.first&.downcase
    date = input_array.last&.downcase
    [ticker, date]
  end

  def valid_date(date)
    date = date.split('-').join('/') # => YYYY/MM/DD
    Date.strptime(date, "%m/%d/%Y") # maybe just need this for validation. otherwise jsut pass it to the ruby clientö.
  end
end
