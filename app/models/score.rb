class Score < ApplicationRecord
  belongs_to :athlete
  belongs_to :workout

  validates :athlete_id, uniqueness: { scope: :workout_id }
end
