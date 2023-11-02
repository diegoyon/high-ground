# frozen_string_literal: true

class WorkoutsController < ApplicationController
  def index
    @workout = selected_workout || default_workout
    @divisions = selected_workout&.divisions || default_divisions
    @division = selected_division || @workout.divisions.first
  end

  private

  def selected_workout
    Workout.visible.find_by(workout_number: params[:workout_number].presence)
  end

  def default_workout
    Workout.visible.order(workout_number: :asc).first || nil
  end

  def default_divisions
    Workout.visible.order(workout_number: :asc).first.divisions || nil
  end

  def selected_division
    Division.find(params[:division_id]) if params[:division_id].present?
  end
end
