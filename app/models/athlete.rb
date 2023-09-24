class Athlete < ApplicationRecord
  has_one :payment, dependent: :destroy
  has_many :scores, dependent: :destroy

  # For future associations if needed
  # has_one :fri_checkout, through: :payment, source: :paymentable, source_type: 'FriCheckout'
  # has_one :recurrente_checkout, through: :payment, source: :paymentable, source_type: 'RecurrenteCheckout'

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

  before_destroy :destroy_checkout

  def full_name
    "#{first_name} #{last_name}"
  end
  
  private
  
  def destroy_checkout
    payment&.paymentable&.destroy if payment
  end
end
