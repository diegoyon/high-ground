class LeaderboardController < ApplicationController
  def index
    @athletes = Athlete.ready.order(:rank)
    filter_athletes
    @workouts = Workout.visible.order(:workout_number)
  end

  private
  
  def filter_athletes
    if params[:division].present?
      @athletes = @athletes.where(division: params[:division])
    else
      @athletes = @athletes.where(division: "Scaled Femenino") #default
    end
  end
end
