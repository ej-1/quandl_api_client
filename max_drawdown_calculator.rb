require 'rest-client'
require 'pry'
require 'json'

class MaxDrawdownCalculator
  Drawdown = Struct.new(:draw_down, :peak_price)

  def initialize(data)
    @data = [
      [1,1,1,1, 1, 100000],
      [1,1,1,1, 1, 150000],
      [1,1,1,1, 1, 90000],
      [1,1,1,1, 1, 120000],
      [1,1,1,1, 1, 80000],
      [1,1,1,1, 1, 200000]
    ]
    @peak_price = @data.first[5]
    @temporary_date_array = []
    @array_of_draw_downs_and_peak_prices = []
  end

  def max_draw_down_percentage # => 0.4666666666666667
    draw_down_percentage max_draw_down
  end

  private

    def draw_down_percentage(draw_down_class) # => 0.4666666666666667
      draw_down_class.draw_down.to_f / draw_down_class.peak_price.to_f
    end

     # => #<struct MaxDrawdownCalculator::Drawdown draw_down=70000, peak_price=150000>
    def draw_down_class(temporary_date_array, peak_price)
      Drawdown.new(calculate_draw_down(peak_price, temporary_date_array), peak_price)
    end

    def calculate_draw_down(peak_price, temporary_date_array) # => 80000
      peak_price - lowest_price_between_peak_prices(temporary_date_array)
    end

    # Find lowest price between old peak price and new peak price.
    def lowest_price_between_peak_prices(dates_between_two_peak_prices) # => 70000
      @dates_between_two_peak_prices.map { |date| date[5] }.min
    end

    def max_draw_down # => #<struct MaxDrawdownCalculator::Drawdown draw_down=70000, peak_price=150000>
      array_of_draw_downs_and_peak_prices.max_by{ |draw_down| draw_down[:draw_down] }
    end

    def array_of_draw_downs_and_peak_prices
      @data.each do |date|
        @dates_between_two_peak_prices << date
        if new_peak_price?(@peak_price, date[5])
          @array_of_draw_downs_and_peak_prices << draw_down_class(@dates_between_two_peak_prices, @peak_price)
          @peak_price = date[5] # Change to new peak price.
          @dates_between_two_peak_prices.clear # Empties the array.
        end
      end
      @array_of_draw_downs_and_peak_prices
    end

    def new_peak_price?(peak_price, price)
      peak_price < price
    end
end

puts MaxDrawdownCalculator.new('bla').max_draw_down_percentage
