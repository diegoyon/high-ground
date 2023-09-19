class FriCheckout < ApplicationRecord
  has_one :payment, as: :paymentable

  validates :fri_username, presence: true, length: { maximum: 50 }
  validates :tshirt_name, length: { maximum: 10 }
end
