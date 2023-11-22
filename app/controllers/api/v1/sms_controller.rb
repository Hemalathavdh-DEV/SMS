class Api::V1::SmsController < Api::V1::ApplicationController
  before_action :authenticate_action, :verify_input
  before_action :check_rate_limit, :verify_cache_key_value_pairs, only: [:outbound_sms]
  before_action :verify_account_phone_number

  def inbound_sms
    processed_status = @account_service.process_text
    return render_already_stopped if processed_status == "stopped"
    return render_param_valid(sms_action)
  end

  def outbound_sms
    return render_param_valid(sms_action)
  end

  private

  def verify_input
    initialize_input_validation_service
    return render_param_missing(@params_missing[:data].keys) unless @params_missing[:message]
    return render_param_invalid(@params_invalid[:data].keys) unless @params_invalid[:message]
  end

  def verify_account_phone_number
    initialize_account_service
    account_service_param = @account_service.verify_phone_number
    return render_param_not_found(account_service_param[0]) unless account_service_param[1]
  end

  def verify_cache_key_value_pairs
    initialize_account_service
    verified_status =  @account_service.verify_cache_pair
    return render_stopped_outbound_error(params["from"], params["to"]) if verified_status
  end

  def check_rate_limit
    result = RedisService.new(nil, params).process_and_verify_rate_limit
    return render_request_limit_reached(params["from"]) if result == "reached"
  end

  def sms_action
    params["action"].split("_")[0]
  end

end
