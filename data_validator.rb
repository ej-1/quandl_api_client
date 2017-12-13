module DataValidator

  def validate(json_data)
    data = json_data['dataset_data']
    validate_data_type(data) && validate_column(data)
  end

  private

    def validate_data_type(data)
      if data['data'].first.nil?
        false
      else
        data['data'].first[4].is_a?(Integer) || data['data'].first[4].is_a?(Float)
      end
    end

    def validate_column(data)
      data['column_names'][4] == 'Close'
    end
end
