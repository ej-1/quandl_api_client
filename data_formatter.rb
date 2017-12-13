class DataFormatter
  attr_reader :table_data

  def initialize(json)
    @data = json
    @table_data = json['dataset_data']['data']
  end

  def closing_prices # => [27.0, 22.0]
    @table_data.map { |row| row[4] }
  end
end
