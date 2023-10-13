# frozen_string_literal: true

module ScoringSystem
  extend ActiveSupport::Concern

  private

  def calculate_points(rank)
    points_map = if rank.between?(1, 6)
                   (1..6).index_with { |n| 100 - (n - 1) * 5 }
                 elsif rank.between?(7, 21)
                   (7..21).index_with { |n| 73 - (n - 7) * 2 }
                 else
                   (22..65).index_with { |n| 44 - (n - 22) }
                 end
    points_map[rank] || 0
  end
end
