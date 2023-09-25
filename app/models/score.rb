class Score < ApplicationRecord
  belongs_to :athlete
  belongs_to :workout

  validates :athlete_id, uniqueness: { scope: :workout_id }

  delegate :workout_type, to: :workout

  after_save :handle_score_changes
  after_destroy :handle_score_changes

  def handle_score_changes
    calculate_points_and_update_rank
    update_athlete_points_and_rank
  end

  def update_athlete_points_and_rank #falta desempatar por event wins
    athlete.update_columns(total_points: athlete.scores.sum(:points))
    athletes = Athlete.all.order(total_points: :desc)
    athletes.each_with_index do |athlete, index|
      athlete.update_columns(rank: index + 1)
    end
  end

  def calculate_points_and_update_rank
    scores = Score.where(workout_id: workout_id).order(main_score_order, tiebreak_score_order)
    rank = 0
    last_main_score = nil
    last_tiebreak_score = nil

    scores.each_with_index do |score, index|
      if score.main_score != last_main_score || score.tiebreak_score != last_tiebreak_score
        rank = index + 1
      end
      score.update_columns(points: calculate_points(rank), rank: rank)
      last_main_score = score.main_score
      last_tiebreak_score = score.tiebreak_score
    end
  end

  def calculate_points(rank)
    case rank
    when 1
      100
    when 2
      95
    when 3
      90
    when 4
      85
    when 5
      80
    when 6
      75
    when 7
      70
    when 8
      65
    when 9
      60
    when 10
      55
    when 11
      50
    when 12
      45
    when 13
      40
    when 14
      35
    when 15
      30
    when 16
      25
    when 17
      20
    when 18
      15
    when 19
      10
    when 20
      5
    else
      0
    end
  end

  private

  def main_score_order
    if workout.workout_type == "For time"
      "main_score ASC"
    elsif workout.workout_type == "AMRAP"
      "main_score DESC"
    end
  end

  def tiebreak_score_order
    if workout.workout_type == "For time"
      "tiebreak_score ASC"
    elsif workout.workout_type == "AMRAP"
      "tiebreak_score DESC"
    end
  end
end
