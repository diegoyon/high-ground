module LeaderboardHelper
  def number_of_columns
    @workouts.count + 2
  end

  def format_time(seconds)
    # duration = ActiveSupport::Duration.build(seconds)
    # duration.parts.map { |part| part.last.to_s.rjust(2, '0') }.join(':')
    minutes = seconds / 60
    seconds = seconds % 60
    formatted_time = format('%02d:%02d', minutes, seconds)
  end

  def format_score(score, measurement_type)
    case measurement_type
    when "AMRAP"
      "#{score} reps"
    when "Weight"
      "#{score} lbs"
    when "Time"
      format_time(score)
    else
      ""
    end
  end
end
