require 'pry'
module Validation

  def validation(validation_data)
    validate = validation_data
    validation_arry = []
    @errors = []
    validate.each do |key, value|
      if key != "invulnerable" && key != "ap_value"
        if value == "" || value == "0"
          validation_arry << key
        end
      end
      if key == "ballistic_skill" && value != "" && value.to_i == 1 || value.to_i >= 7
        @errors << 'Ballistic skills is invalid'
      end
    end

    if !validation_arry.nil?
      validation_arry.each do |names|
        @errors << "#{names.gsub(/_/, ' ')} value was 0 or not filled in"
      end
    end

    if @errors.length
      @validated = false
      return @errors
    end
  end
end
