class InputValidationService
  include Validator
  def initialize(params)
    @params = params
  end

  def validate_required_input_params
    if required_input_hash.values.include?(false)
      return {message: false, data: required_input_hash.select{|k, v| v == false}}
    else
      return {message: true}
    end
  end

  def validate_input_params
    if validation_input_hash.values.include?(false)
      return {message: false, data: validation_input_hash.select{|k, v| v == false}}
    else
      return {message: true}
    end
  end

  private

  def validate_from
    @params["from"].present? ? is_in_length?(@params["from"]) : false
  end

  def validate_to
    @params["to"].present? ? is_in_length?(@params["to"]) : false
  end

  def validate_text
    @params["text"].present? ? is_text_in_length?(@params["text"]) : false
  end

  def validation_input_hash
    {
      "from" => validate_from,
      "to" => validate_to,
      "text" => validate_text
    }
  end

  def required_input_hash
    {
      "from" => @params["from"].present?,
      "to" => @params["to"].present?,
      "text" => @params["text"].present?
    }
  end
end