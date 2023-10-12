# frozen_string_literal: true

module Admin
  class LeaderboardController < ApplicationController
    before_action :authenticate_user!

    include FilterActions

    def index
      @athletes = Athlete.ready.order(:rank)
      search_athletes
      filter_athletes
      @workouts = Workout.visible.order(:workout_number)
    end
  end
end
