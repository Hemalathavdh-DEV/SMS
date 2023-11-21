class Api::V1::ApplicationController < ActionController::API

	# Rails API is a subset of the base Rails library, and by default doesn’t include the modules to handle the authenticate_with_http_basic method. You’ll need to include these modules in your application_controller.rb.
	include ActionController::HttpAuthentication::Basic::ControllerMethods
	include ActionController::HttpAuthentication::Token::ControllerMethods

	before_action :authenticate, only: [:authenticate_action]

	def method_not_allowed
		render json: { error: "HTTP #{request.method} request method Not Allowed" }, status: :method_not_allowed
	end

	private

	def authenticate_action
		authenticate_with_http_basic do |username, password|
			account = Account.find_by(username: username)

			# If the user is not found or authentication fails, return a 403 Forbidden response.
			unless account && account.authenticate(password)
				render json: { error: 'Authentication failed' }, status: :forbidden
				return
			else
				@current_account = account
			end
    end
	end
end
