class Account < ApplicationRecord
  has_secure_password :auth_id
  #validations
  validates :username, uniqueness: true, presence: true
  validates :auth_id, presence: true, length: { in: 6..16 }

  #association
  has_many :phone_numbers, dependent: :destroy

  #delegates
  delegate :account_phone_numbers, to: :phone_numbers
end
