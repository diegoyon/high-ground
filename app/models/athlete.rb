class Athlete < ApplicationRecord
  has_one :payment

  accepts_nested_attributes_for :payment

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, length: { maximum: 50 }
  validates :phone, presence: true, length: { maximum: 20 }
  validates :tshirt_size, presence: true
  validates :box, presence: true, length: { maximum: 50 }
  validates :division, presence: true
  validates :tshirt_name, length: { maximum: 10 }

  delegate :payment_status, to: :payment, allow_nil: true

  scope :ready, -> { joins(:payment).where(payments: { payment_status: 'completed' }) }
end
