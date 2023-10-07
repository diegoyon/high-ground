class Admin::LeaderboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @athletes = Athlete.ready.order(:rank)
    search_athletes
    filter_athletes
    @workouts = Workout.visible.order(:workout_number)
  end

  private

  def search_athletes
    return unless params[:query].present?
    @athletes = @athletes.where('lower(first_name || \' \' || last_name) LIKE :query', query: "%#{params[:query].downcase}%")
  end

  def filter_athletes
    if params[:division].present?
      @athletes = @athletes.where(division: params[:division])
    else
      @athletes = @athletes.where(division: "Scaled Femenino") #default
    end
  end
end
