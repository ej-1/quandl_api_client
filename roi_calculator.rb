module RoiCalculator

  def return_on_investment(initial_price, final_value)
    price_change(final_value, initial_price) / initial_price
  end

  private

    def price_change(final_value, initial_price)
      final_value - initial_price
    end
end
