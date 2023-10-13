# frozen_string_literal: true

class Workout < ApplicationRecord
  has_many :scores, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :workout_type, presence: true
  validates :tiebreak_type, presence: true
  validates :workout_number, presence: true, uniqueness: true
  validates :time_cap, presence: true

  scope :visible, -> { where(visible: true) }
end
