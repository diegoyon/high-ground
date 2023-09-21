class Workout < ApplicationRecord
  has_and_belongs_to_many :athletes
  has_many :scores, dependent: :destroy
end
