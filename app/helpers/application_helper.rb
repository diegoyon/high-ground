module ApplicationHelper
  def format_time(seconds)
    return if seconds.nil?
    minutes = seconds / 60
    seconds = seconds % 60
    formatted_time = format('%02d:%02d', minutes, seconds)
  end
end
