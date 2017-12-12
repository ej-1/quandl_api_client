class DataFormatter
  attr_reader :table_data

  def initialize(json)
    @data = json
    @table_data = json['datatable']['data']
  end

  def closing_prices # => [{ close_price: 27.7 }]
    # REFACTOR - USE STRUCT HERE INSTEAD.
    # MAYBE PUT THIS AS A FORMATTING METHOD IN MAXDRAWDOWNCALCULATOR. PAGE 28 IN POODR BOOK,
    # OR SHOULD I GO WITH CREATING A MODULE INSTEAD.
    # EATHER WAY, SHOULD DEFINATELY BE INCLUDED IN MAXDRAWDOWNCALCULATOR, NOT IN COMMANDRUNNER.
    # EMBEDDING IT MAY SUGGEST THAT THE FORMAT ONLY EXISTS FOR THIS THE CONTECTS OF CALCULATING MAXDRAWDOWN, WHICH
    # I THINK IS CORRECT. PAGE 32 IN POODR.
    @table_data.map { |row| row[5] }
  end
end
