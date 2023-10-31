# frozen_string_literal: true

class WorkoutsController < ApplicationController
  def index
    @workout = Workout.visible.find_by(workout_number: params[:workout_number].presence) || default_workout
  end

  private

  def default_workout
    Workout.visible.order(workout_number: :asc).first || nil
  end
end
