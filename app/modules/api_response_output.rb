module ApiResponseOutput

  def render_method_not_allowed
    render json: construct_hash_response(api_responses["failure"], api_responses["method_not_allowed"]["message"]), status: :method_not_allowed
  end

  def render_unauthenticated
    render json: construct_hash_response(api_responses["failure"], api_responses["unauthenticated"]["message"]), status: :forbidden
  end

  def render_param_missing(params)
    render json: construct_hash_response("", "#{params.join(" ,")} #{plural_verb(params)} #{api_responses["param_missing"]["message"]}"), status: :unprocessable_entity
  end

  def render_param_invalid(params)
    render json: construct_hash_response("", "#{params.join(" ,")} #{plural_verb(params)} #{api_responses["param_invalid"]["message"]}"), status: :unprocessable_entity
  end

  def render_param_not_found(param)
    render json: construct_hash_response("", "#{param} #{api_responses["param_not_found"]["message"]}"), status: :unprocessable_entity
  end

  def render_param_valid(action)
    render json: construct_hash_response("#{action} #{api_responses["valid"]["message"]}", ""), status: :ok
  end

  def render_already_stopped
    render json: construct_hash_response(api_responses["already_stopped"]["message"], ""), status: :ok
  end

  def render_stopped_outbound_error(from, to)
    config_data = YAML.safe_load(ERB.new(File.read('config/api_responses.yml')).result(binding))
    render json: construct_hash_response("", config_data["api_responses"]["sms_blocked"]["message"]), status: :unprocessable_entity
  end

  def render_request_limit_reached(from)
    render json: construct_hash_response("", "limit reached for from #{from}"), status: :too_many_requests
  end

  private

  def api_responses
    API_RESPONSES["api_responses"]
  end

  def construct_hash_response(message, error)
    {
      message: message,
      error: error
    }
  end

  def plural_verb(params)
    params.length > 1 ? ENG_ARE : ENG_IS
  end
end