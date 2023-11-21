class Account < ApplicationRecord
	#validations
	validates :username, uniqueness: true
	validates :auth_id, presence: true

	#association
	has_many :phone_numbers, dependent: :destroy

	#callbacks
	before_save :encrypted_auth_id

	def authenticate(entered_auth_id)
		decrypt(auth_id) == entered_auth_id
	end

	private

	def encrypted_auth_id
		self.auth_id = Base64.encode64(auth_id)
	end

	def decrypt(encrypted_string)
		Base64.decode64(encrypted_string)
	end
end
