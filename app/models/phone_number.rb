class PhoneNumber < ApplicationRecord
  #Validations
  validates :number, uniqueness: { scope: :account_id}, length: { in: 6..16 }

  #Associations
  belongs_to :account
end
