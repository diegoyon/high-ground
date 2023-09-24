class LeaderboardController < ApplicationController
  def index
    @athletes = Athlete.ready
    @workouts = Workout.order(:workout_number)
  end
end
