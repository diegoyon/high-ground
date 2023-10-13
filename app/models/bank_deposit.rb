# frozen_string_literal: true

class BankDeposit < ApplicationRecord
  has_one :payment, as: :paymentable, dependent: :destroy

  validates :amount, presence: true
end
