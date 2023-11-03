# frozen_string_literal: true

class WorkoutsController < ApplicationController
  def index
    @workout = selected_workout || default_workout
    @division = selected_division || default_division if @workout
  end

  private

  def selected_workout
    Workout.visible.find_by(workout_number: params[:workout_number].presence)
  end

  def default_workout
    Workout.visible.order(workout_number: :asc).first || nil
  end

  def selected_division
    @workout.divisions.find_by(name: params[:division_name].presence)
  end

  def default_division
    @workout.divisions.find_by(name: 'Scaled')
  end
end
