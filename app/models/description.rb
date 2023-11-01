# frozen_string_literal: true

class Description < ApplicationRecord
  belongs_to :workout

  validates :text, presence: true
  validates :division, presence: true
  validates :division, uniqueness: { scope: :workout_id }
end
