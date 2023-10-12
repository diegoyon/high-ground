# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :athlete
  belongs_to :paymentable, polymorphic: true

  accepts_nested_attributes_for :paymentable
end
