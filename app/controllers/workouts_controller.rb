# frozen_string_literal: true

class WorkoutsController < ApplicationController
  def index
    @workout = Workout.find(params[:workout_id].presence || 1)
  end
end
