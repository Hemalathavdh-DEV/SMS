module ErrorHandler
  def self.included(clazz)
    clazz.class_eval do
      rescue_from StandardError do |e|
        respond(API_RESPONSES["api_responses"]["unknown"]["message"], 500, "")
      end
      rescue_from ActiveRecord::RecordNotFound do |e|
        respond(:record_not_found, 404, e.to_s)
      end
    end
  end

  private

  def respond(_error, _status, _message)
    render json: {message: _message, error: _error}.to_json, status: _status
  end
end