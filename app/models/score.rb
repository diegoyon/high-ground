class Score < ApplicationRecord
  belongs_to :athlete
  belongs_to :workout
end
