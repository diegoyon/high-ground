# frozen_string_literal: true

module ScoresHelper
  def score_placeholder(workout_or_tiebreak_type)
    case workout_or_tiebreak_type
    when 'AMRAP'
      'Reps'
    when 'Weight'
      'Weight'
    when 'Time'
      'MM:SS'
    else
      ''
    end
  end

  def cap_score_value(score)
    return unless score.main_score

    if (score.main_score - score.time_cap).positive?
      score.main_score - score.time_cap
    else
      ''
    end
  end

  def main_score_value(score)
    return unless score.main_score

    if score.workout_type == 'Time'
      if score.main_score <= score.time_cap
        format_time(score.main_score)
      else
        format_time(score.time_cap)
      end
    else
      score.main_score
    end
  end
end
