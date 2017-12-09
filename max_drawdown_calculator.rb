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
    @array_of_draw_downs = []
  end
  #Max draw_down = (Peak value before largest draw_down - Lowest value before new high established) /
  # (Peak value before largest draw_down)
  def max_draw_down_percentage
    # has to remember each draw_down in a array. [draw_down, draw_down, draw_down]
    # at the end pick the one with the highest number

    # also has to remember the highest peak price.

    # take first price and compare to next price if it lower of higher.
    # if price is higher that that price is the new peak price.
    # if lower keep the the old peak price.

    # loop over to find the next value that is higher than the peak price.

    # between the first peak price and the new peak price. look for the lowest price.
    # the difference between the lowest price and the first peak is a draw_down.
    # save the draw_down to an array.
    # then continue to look for new draw_downs.
    # at the end compare the array of draw_downs to find the highests.

    # = (150 000 - 80 000) / 150 000 = 47,67% = 0.4767
    binding.pry

    draw_down_percentage max_draw_down
  end

  private

    def draw_down_percentage(draw_down_class) # => 0.4666666666666667
      draw_down_class.draw_down.to_f / draw_down_class.peak_price.to_f
    end

    def draw_down_class(temporary_date_array, peak_price)
      Drawdown.new(calculate_draw_down(peak_price, temporary_date_array), peak_price)
    end

    def calculate_draw_down(peak_price, temporary_date_array)
      peak_price - lowest_price_between_peak_prices(temporary_date_array)
    end

    # Find lowest price between old peak price and new peak price.
    def lowest_price_between_peak_prices(temporary_date_array)
      @temporary_date_array.map { |date| date[5] }.min
    end

    def max_draw_down # => #<struct MaxDrawdownCalculator::Drawdown draw_down=70000, peak_price=150000>
      array_of_draw_downs.max_by{ |draw_down| draw_down[:draw_down] }
      #draw_down.max_by{ |draw_down| draw_down[:draw_down] }
    end

    def array_of_draw_downs
      @data.each do |date|
        @temporary_date_array << date
        if new_peak_price?(@peak_price, date[5])
          @array_of_draw_downs << draw_down_class(@temporary_date_array, @peak_price)
          @peak_price = date[5] # Reset peak price
          @temporary_date_array.clear # Empties the array.
        end
      end
      @array_of_draw_downs
    end

    def new_peak_price?(peak_price, price)
      peak_price < price
    end
end

MaxDrawdownCalculator.new('bla').max_draw_down_percentage
