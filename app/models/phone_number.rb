class PhoneNumber < ApplicationRecord
  #Validations
  validates :number, uniqueness: { scope: :account_id}, length: { in: 6..16 }, numericality: { only_integer: true }

  #Associations
  belongs_to :account

  private

  def self.account_phone_numbers
    pluck(:number)
  end
end
