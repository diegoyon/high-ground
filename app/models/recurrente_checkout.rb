class RecurrenteCheckout < ApplicationRecord
  has_one :payment, as: :paymentable
end