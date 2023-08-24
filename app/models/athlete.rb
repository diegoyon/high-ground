class Athlete < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, length: { minimum: 2, maximum: 80 }
  validates :phone, presence: true, length: { minimum: 2, maximum: 20 }
  validates :fri_username, presence: true, length: { minimum: 1, maximum: 50 }
end
