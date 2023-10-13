# frozen_string_literal: true

module LeaderboardHelper
  def format_score(score)
    case score.workout_type
    when 'AMRAP'
      "#{score.main_score} reps"
    when 'Weight'
      "#{score.main_score} lbs"
    when 'Time'
      time_or_capped(score)
    else
      ''
    end
  end

  def time_or_capped(score)
    if score.capped
      "CAP + #{score.main_score - score.time_cap}"
    else
      format_time(score.main_score)
    end
  end

  def format_tiebreak_score(score)
    case score.tiebreak_type
    when 'AMRAP'
      "#{score.tiebreak_score} reps"
    when 'Weight'
      "#{score.tiebreak_score} lbs"
    when 'Time'
      format_time(score.tiebreak_score)
    else
      ''
    end
  end

  def format_rank(rank)
    case rank
    when 1
      '1st'
    when 2
      '2nd'
    when 3
      '3rd'
    else
      "#{rank}th"
    end
  end
end
