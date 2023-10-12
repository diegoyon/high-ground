# frozen_string_literal: true

class LeaderboardController < ApplicationController
  include FilterActions

  def index
    @athletes = Athlete.ready.order(:rank).includes(:scores)
    filter_athletes
    @workouts = Workout.visible.order(:workout_number)
  end
end
