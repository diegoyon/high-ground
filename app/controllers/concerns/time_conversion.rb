# frozen_string_literal: true

module TimeConversion
  extend ActiveSupport::Concern

  private

  def time_to_seconds(time)
    minutes, seconds = time.split(':')
    minutes.to_i * 60 + seconds.to_i
  end
end
