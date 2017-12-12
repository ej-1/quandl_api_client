require 'pry'

class MaxDrawdownCalculator
  attr_reader :close_prices

  def initialize(close_prices)
    @close_prices = close_prices #[100000, 150000, 90000, 120000, 80000, 200000]
  end

  def max_drawdown_percentage
    hash = max_drawdown_and_initial_peak_price
    hash[:draw_down].to_f / hash[:peak_price].to_f
  end

  private

    # range of prices between a peak price and the next,
    # including first peak price, but not last peak price.
    def price_valleys #=> [[100000], [150000, 90000, 120000, 80000]]
      close_prices.each_with_index.map do |price, i|
        previous_peak_price = close_prices[0]
        close_prices.shift(i) if new_peak_price?(previous_peak_price, price)
      end.compact
    end

    # => [{:draw_down=>0, :peak_price=>100000},
    #    {:draw_down=>70000, :peak_price=>150000}]
    def drawdowns_and_start_peak_prices
      price_valleys.map do |price_valley|
        peak_price = initial_peak_price_in(price_valley)
        { draw_down: draw_down(peak_price, lowest_price_in(price_valley)),
          peak_price: peak_price}
      end
    end

    def initial_peak_price_in(price_valley)
      price_valley[0]
    end

    def lowest_price_in(price_array)
      price_array.min
    end

    def draw_down(peak_price, lowest_price)
      peak_price - lowest_price
    end

    def max_drawdown_and_initial_peak_price
      drawdowns_and_start_peak_prices.
        max_by{ |drawdown_and_peak_price| drawdown_and_peak_price[:draw_down] }
    end

    def new_peak_price?(previous_peak_price, price)
      previous_peak_price < price
    end
end
