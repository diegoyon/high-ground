class LeaderboardController < ApplicationController
  def index
    @athletes = Athlete.ready.order(:rank)
    search_athletes
    filter_athletes
    @workouts = Workout.order(:workout_number)
  end

  private

  def search_athletes
    return unless params[:query].present?
    @athletes = @athletes.where('lower(first_name || \' \' || last_name) LIKE :query', query: "%#{params[:query].downcase}%")
  end

  def filter_athletes
    return unless params[:division].present?
    @athletes = @athletes.where('division = ?', params[:division])
  end
end
