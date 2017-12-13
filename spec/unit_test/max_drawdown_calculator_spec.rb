require 'spec_helper'
require './max_drawdown_calculator.rb'

describe MaxDrawdownCalculator do

  context 'receives valid ticker and date' do
    it 'calculates max drawdown' do
      closing_prices = [100000, 150000, 90000, 120000, 80000, 200000]
      @max_drawdown_calculator = MaxDrawdownCalculator.new(closing_prices)
      expect(@max_drawdown_calculator.max_drawdown_percentage).to eq(0.4666666666666667)
    end
  end
end
