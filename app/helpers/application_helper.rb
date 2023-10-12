# frozen_string_literal: true

module ApplicationHelper
  def format_time(seconds)
    return if seconds.nil?

    minutes = seconds / 60
    seconds = seconds % 60
    format('%02d:%02d', minutes, seconds)
  end
end
