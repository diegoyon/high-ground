module LeaderboardHelper
  def number_of_columns
    @workouts.count + 2
  end

  def format_time(seconds)
    duration = ActiveSupport::Duration.build(seconds)
    duration.parts.map { |part| part.last.to_s.rjust(2, '0') }.join(':')
  end
end
