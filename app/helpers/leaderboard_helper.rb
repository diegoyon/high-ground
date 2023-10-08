module LeaderboardHelper
  def number_of_columns
    @workouts.count + 2
  end

  def format_score(score, measurement_type, time_cap = nil)
    case measurement_type
    when "AMRAP"
      "#{score} reps"
    when "Weight"
      "#{score} lbs"
    when "Time"
      if time_cap.present? && score > time_cap
        "CAP + #{score - time_cap}"
      else
        format_time(score)
      end
    else
      ""
    end
  end

  def format_rank(rank)
    case rank
    when 1
      "1st"
    when 2
      "2nd"
    when 3
      "3rd"
    else
      "#{rank}th"
    end
  end

end
