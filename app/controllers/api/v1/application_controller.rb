class Api::V1::ApplicationController < ActionController::API
  # Rails API is a subset of the base Rails library, and by default doesn’t include the modules to handle the authenticate_with_http_basic method. You’ll need to include these modules in your application_controller.rb.
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  #Error Handler
  include ErrorHandler

  #Response Format
  include ApiResponseOutput

  @@api_responses = API_RESPONSES["api_responses"]

  def method_not_allowed
    render_method_not_allowed
  end

  private

  def authenticate_action
    authenticate_with_http_basic do |username, password|
      account = Account.find_by(username: username)
      # If the user is not found or authentication fails, return a 403 Forbidden response.
      unless account && account.authenticate(password)
        render_unauthenticated
        return
      else
        @current_account = account
      end
    end
  end
end
