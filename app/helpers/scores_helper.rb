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
end
