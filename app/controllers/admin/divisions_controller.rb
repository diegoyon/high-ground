# frozen_string_literal: true

module Admin
  class DivisionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_division, only: %i[edit update]

    def edit; end

    def update
      if @division.update(division_params)
        redirect_to admin_workouts_url, notice: 'Division was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_division
      @division = Division.find(params[:id])
    end

    def division_params
      params.require(:division).permit(:description)
    end
  end
end
