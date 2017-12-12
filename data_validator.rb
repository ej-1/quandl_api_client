module DataValidator

  def validate(json_data)
    data = json_data['datatable']
    validate_data_type(data) && validate_column(data)
  end

  private

    def validate_data_type(data)
      data['data'].first[5].is_a?(Integer) || data['data'].first[5].is_a?(Float)
    end

    def validate_column(data)
      data['columns'][5]['name']&.downcase == 'close'
    end
end
