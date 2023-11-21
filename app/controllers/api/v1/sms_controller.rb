class Api::V1::SmsController < Api::V1::ApplicationController
	before_action :authenticate_action
	def inbound_sms
	end

	def outbound_sms
	end
end
