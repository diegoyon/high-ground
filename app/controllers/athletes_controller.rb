class AthletesController < ApplicationController
  def index
    @athletes = Athlete.ready
    @workouts = Workout.all
  end
end
