# frozen_string_literal: true

class Workout < ApplicationRecord
  has_many :scores, dependent: :destroy
  has_many :divisions, inverse_of: :workout, dependent: :destroy

  accepts_nested_attributes_for :divisions, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  validates :workout_type, presence: true
  validates :tiebreak_type, presence: true
  validates :workout_number, presence: true, uniqueness: true
  validates :time_cap, presence: true

  scope :visible, -> { where(visible: true) }

  def formatted_name
    "Workout #{workout_number}"
  end
end
