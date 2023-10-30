# frozen_string_literal: true

class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.order(:workout_number)
  end
end
