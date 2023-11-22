require 'rails_helper'

RSpec.describe 'SMS API', type: :feature do
  context 'Outbound SMS' do
    # Commenting as need to know how to get instance variable
    # it 'returns HTTP 422 if the pair ‘to’, ‘from’ matches any entry in cache (STOP)' do
    #   # Assuming you have a cached entry with 'from' and 'to'
    #   valid_request = { from: '123456', to: '654321', text: 'Hello World' }
    #   create_stop_cache_entry(valid_request[:from], valid_request[:to])
    #   page.driver.header('Authorization', ActionController::HttpAuthentication::Basic.encode_credentials('jeee', '89999'))
    #   page.driver.post '/api/v1/sms/outbound', valid_request
    #   expect(page.status_code).to eq(422)
    # end

    it 'returns HTTP 429 if 50 requests in the last 24 hours with the same ‘from’ parameter' do
      # Assuming you have made 50 requests in the last 24 hours with the same 'from' parameter

      valid_request = { from: '999999999999', to: '654321', text: 'Hello World' }
      create_rate_limit_cache_entry(valid_request[:from])
      page.driver.header('Authorization', ActionController::HttpAuthentication::Basic.encode_credentials('jeee', '89999'))
      page.driver.post '/api/v1/sms/outbound', valid_request
      expect(page.status_code).to eq(429)
    end
  end
end

def create_stop_cache_entry(from, to)
  # Create a cached entry with 'from' and 'to' for STOP condition
  cache_key = "STOP_PAIR__#{from}_#{to}"
  $redis.hmset(cache_key, 'from', from, 'to', to)
  $redis.expire(cache_key, 4.hours.to_i)
end

def create_rate_limit_cache_entry(from)
  # Increment the request count for the specified 'from' parameter
  rate_limit_key = "RATE_LIMIT:#{from}"
  $redis.set(rate_limit_key, 50)
  $redis.expire(rate_limit_key, 24.hours.to_i)
end
