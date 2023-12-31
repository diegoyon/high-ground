# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :athlete
  belongs_to :workout

  include ScoringSystem

  attr_accessor :submitted_score, :cap_score

  validates :athlete_id, uniqueness: { scope: :workout_id }
  validates :tiebreak_score, presence: true, if: :tiebreak?
  validates :tiebreak_score, numericality: { less_than_or_equal_to: :time_cap }, if: -> { tiebreak_type == 'Time' }
  validates :submitted_score, presence: true
  validates :submitted_score, numericality: { less_than_or_equal_to: :time_cap }, if: -> { workout_type == 'Time' }
  validates :cap_score, presence: true, if: :capped
  validates :cap_score, numericality: { greater_than: 0 }, if: :capped

  delegate :workout_type, :tiebreak_type, :time_cap, to: :workout

  after_save :handle_score_changes
  after_destroy :handle_score_changes

  def tiebreak?
    tiebreak_type != 'None'
  end

  private

  def handle_score_changes
    calculate_score_points_and_rank
    update_athletes_total_points
    update_athletes_rank
  end

  def update_athletes_total_points
    athletes = Athlete.ready.where(division: athlete.division)
    athletes.each do |athlete|
      athlete.total_points = athlete.scores.sum(:points)
      athlete.save
    end
  end

  def update_athletes_rank
    athletes = Athlete.ready.where(division: athlete.division).order(total_points: :desc)
    rank = 0
    last_total_points = nil

    athletes.each_with_index do |athlete, index|
      rank = index + 1 if athlete.total_points != last_total_points
      athlete.rank = rank
      athlete.save
      last_total_points = athlete.total_points
    end
  end

  def calculate_score_points_and_rank
    scores = fetch_scores_in_order
    rank = 0
    last_main_score = nil
    last_tiebreak_score = nil

    scores.each_with_index do |score, index|
      rank = index + 1 if score.main_score != last_main_score || score.tiebreak_score != last_tiebreak_score
      score.update_columns(points: calculate_points(rank), rank:)
      last_main_score = score.main_score
      last_tiebreak_score = score.tiebreak_score
    end
  end

  def fetch_scores_in_order
    Score.joins(:athlete).where(athletes: { division: athlete.division }).where(workout_id:).order(
      main_score_order, tiebreak_score_order
    )
  end

  def main_score_order
    if workout_type == 'Time'
      'main_score ASC'
    else
      'main_score DESC'
    end
  end

  def tiebreak_score_order
    if tiebreak_type == 'Time'
      'tiebreak_score ASC'
    else
      'tiebreak_score DESC'
    end
  end
end
