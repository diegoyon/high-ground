class Workout < ApplicationRecord
  has_many :scores, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :workout_type, presence: true
  validates :tiebreak_type, presence: true
  validates :workout_number, presence: true, uniqueness: true
  validates :time_cap, presence: true, if: -> { workout_type == "Time" }

  scope :visible, -> { where(visible: true) }

  before_save :set_time_cap_to_nil unless -> { workout_type == "Time" }

  private

  def set_time_cap_to_nil
    return unless time_cap.present?
    self.time_cap = nil
  end
end
