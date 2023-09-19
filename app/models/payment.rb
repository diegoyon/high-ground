class Payment < ApplicationRecord
  belongs_to :athlete
  belongs_to :paymentable, polymorphic: true
end
