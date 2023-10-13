# frozen_string_literal: true

class FriCheckout < ApplicationRecord
  has_one :payment, as: :paymentable, dependent: :destroy

  validates :fri_username, presence: true, length: { maximum: 50 }
end
