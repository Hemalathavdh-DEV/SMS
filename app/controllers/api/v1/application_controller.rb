class Api::V1::ApplicationController < ActionController::API
  # Rails API is a subset of the base Rails library, and by default doesn’t include the modules to handle the authenticate_with_http_basic method. You’ll need to include these modules in your application_controller.rb.
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  #Error Handler
  include ErrorHandler

  #Response Format
  include ApiResponseOutput

  def method_not_allowed
    render_method_not_allowed
  end

  private

  def authenticate_action
    authenticate_with_http_basic do |username, password|
      account = Account.find_by(username: username)
      # If the user is not found or authentication fails, return a 403 Forbidden response.
      unless account && account.authenticate_auth_id(password).present?
        render_unauthenticated
        return
      else
        @current_account = account
      end
    end
  end

   def initialize_account_service
    @account_service = AccountService.new(@current_account, params)
  end

  def initialize_input_validation_service
    input_validation_service = InputValidationService.new(params)
    @params_missing = input_validation_service.validate_required_input_params
    @params_invalid = input_validation_service.validate_input_params
  end
end
