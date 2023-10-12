# frozen_string_literal: true

class LeaderboardController < ApplicationController
  def index
    @athletes = Athlete.ready.order(:rank).includes(:scores)
    filter_athletes
    @workouts = Workout.visible.order(:workout_number)
  end

  private

  def filter_athletes
    @athletes = if params[:division].present?
                  @athletes.where(division: params[:division])
                else
                  @athletes.where(division: 'Scaled Femenino') # default
                end
  end
end
