require './command_input_parse_validator.rb'
require 'date'

describe CommandInputParseAndValidator do

  before do
    @dummy_class = Class.new
    @dummy_class.extend(CommandInputParseAndValidator)
  end

  describe do 'receives wrong number of arguments'
    context 'too many' do
      it 'throws error' do
        input = 'AAPL AAPL 2013-01-01'
        STDOUT.should_receive(:puts).with('Too many or to few arguments. Use AAPL 2013-01-01')
        expect(@dummy_class.parse_and_validate_input(input)).to eq([nil, nil])
      end

      it 'throws error' do
        input = 'AAPL'
        STDOUT.should_receive(:puts).with('Too many or to few arguments. Use AAPL 2013-01-01')
        expect(@dummy_class.parse_and_validate_input(input)).to eq([nil, nil])
      end
    end
  end

  describe do 'receives correct date format'
    context 'correct date' do
      it 'throws error' do
        input = 'AAPL 2013-01-01'
        expect(@dummy_class.parse_and_validate_input(input)).to eq(['aapl', '2013-01-01'])
      end
    end
  end

  describe do 'receives wrong date format'
    context 'wrong date order' do
      it 'throws error' do
        input = 'AAPL 01-01-2013'
        STDOUT.should_receive(:puts).with('Invalid date format. Should be YYYY-MM-DD')
        expect(@dummy_class.parse_and_validate_input(input)).to eq([nil, nil])
      end
    end

    context 'wrong year format' do
      it 'throws error' do
        input = 'AAPL 201321-01-01'
        STDOUT.should_receive(:puts).with('Invalid date format. Should be YYYY-MM-DD')
        expect(@dummy_class.parse_and_validate_input(input)).to eq([nil, nil])
      end
    end

    context 'wrong month format' do
      it 'throws error' do
        input = 'AAPL 2013-1-01'
        STDOUT.should_receive(:puts).with('Invalid date format. Should be YYYY-MM-DD')
        expect(@dummy_class.parse_and_validate_input(input)).to eq([nil, nil])
      end
    end

    context 'wrong day format' do
      it 'throws error' do
        input = 'AAPL 2013-01-231'
        expect(@dummy_class.parse_and_validate_input(input)).to eq([nil, nil])
      end
    end
  end
end
