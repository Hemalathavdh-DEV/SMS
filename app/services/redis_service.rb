class RedisService
  def initialize(account, params)
    @account = account
    @from = params["from"]
    @to = params["to"]
  end

  def process
    return STOPPED if $redis.exists(cache_key) == 1

    # Set the hash in Redis using HMSET
    $redis.hmset(cache_key, cache_entry)

    # Set an expiration time for the key (e.g., 4 hours)
    $redis.expire(cache_key, FOUR_HOURS)
  end

  def check_pair_exists
    # Using redis-rb to check if the pair exists
    result = $redis.hmget(cache_key, "from", "to")
    exists_or_not = result[0] == @from && result[1] == @to ? true : false
    return exists_or_not
  end

  def process_and_verify_rate_limit
    # Check the number of API requests in the last 24 hours
    request_count = $redis.get(rate_limit_key).to_i || 0

    return REACHED if request_count >= 50

    # Increment the request count and set a 24-hour expiration if its first request
    $redis.multi do
      $redis.incr(rate_limit_key)
      $redis.expire(rate_limit_key, 24.hours.to_i) if request_count.zero?
    end
  end

  private

  def cache_key
    "#{STOP_PAIR}_#{@account.id}_#{@from}_#{@to}"
  end

  def cache_entry
    { from: @from, to: @to }
  end

  def rate_limit_key
    "#{RATE_LIMIT}:#{@from}"
  end

end