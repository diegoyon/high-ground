class LeaderboardController < ApplicationController
  def index
    @athletes = Athlete.ready.order(:rank)
    @workouts = Workout.order(:workout_number)
  end
end
