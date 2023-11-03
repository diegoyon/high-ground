# frozen_string_literal: true

class Division < ApplicationRecord
  belongs_to :workout

  validates :name, presence: true
  validates :name, uniqueness: { scope: :workout_id }
end
