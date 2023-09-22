class Workout < ApplicationRecord
  has_many :scores, dependent: :destroy
end
