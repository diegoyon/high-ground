# frozen_string_literal: true

module Admin
  class WorkoutsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_workout, only: %i[show edit update destroy]

    include TimeConversion

    def index
      @workouts = Workout.order(:workout_number).includes(:descriptions)
    end

    def show; end

    def new
      @workout = Workout.new
      @workout.descriptions.build
    end

    def edit; end

    def create
      modified_workout_params = workout_params.dup
      if modified_workout_params[:time_cap].present?
        modified_workout_params = transform_time_cap_to_seconds(modified_workout_params)
      end
      @workout = Workout.new(modified_workout_params)

      if @workout.save
        redirect_to admin_workout_url(@workout), notice: 'Workout was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      modified_workout_params = workout_params.dup
      if modified_workout_params[:time_cap].present?
        modified_workout_params = transform_time_cap_to_seconds(modified_workout_params)
      end

      if @workout.update(modified_workout_params)
        redirect_to admin_workout_url(@workout), notice: 'Workout was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @workout.destroy

      redirect_to admin_workouts_url, notice: 'Workout was successfully destroyed.'
    end

    private

    def set_workout
      @workout = Workout.find(params[:id])
    end

    def workout_params
      params.require(:workout).permit(:name, :description, :workout_type, :workout_number, :tiebreak_type, :time_cap,
                                      :visible, descriptions_attributes: %i[id text division _destroy])
    end

    def transform_time_cap_to_seconds(modified_workout_params)
      modified_workout_params[:time_cap] = time_to_seconds(modified_workout_params[:time_cap])
      modified_workout_params
    end
  end
end
