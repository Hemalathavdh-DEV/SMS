class AccountService
  def initialize(account, params)
    @account = account
    @params = params
  end

  def verify_phone_number
    return setting_action_param[0], @account.account_phone_numbers.include?(setting_action_param[1])
  end

  def process_text
    process_to_redis if stop_condition_met?(@params["text"])
  end

  def verify_cache_pair
    check_redis_cache
  end

  private

  def setting_action_param
    case @params["action"]
    when "inbound_sms"
      ["to", @params["to"]]
    when "outbound_sms"
      ["from", @params["from"]]
    end
  end

  def stop_condition_met?(text)
    # Define your stop condition logic here
    text =~ /\A\s*STOP\s*\z/i
  end

  def initialize_redis
    RedisService.new(@account, @params)
  end

  def process_to_redis
    initialize_redis.process
  end

  def check_redis_cache
    initialize_redis.check_pair_exists
  end
end