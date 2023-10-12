# frozen_string_literal: true

class RecurrenteCheckout < ApplicationRecord
  has_one :payment, as: :paymentable
end
