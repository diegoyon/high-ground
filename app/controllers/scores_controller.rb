# frozen_string_literal: true

class ScoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_score, only: %i[show edit update destroy]

  include TimeConversion

  def index
    @scores = Score.all.includes(:athlete, :workout)
  end

  def show; end

  def new
    @score = Score.new
    @score.athlete = Athlete.find(params[:athlete_id])
    @score.workout = Workout.find(params[:workout_id])
  end

  def edit; end

  def create
    @score = build_score

    if @score.save
      redirect_to admin_leaderboard_index_path, notice: 'Score was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    modified_score_params = transform_time_scores_params(@score, score_params.dup)

    if @score.update(modified_score_params.except(:cap_score))
      redirect_to admin_leaderboard_index_path, notice: 'Score was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @score.destroy

    redirect_to admin_leaderboard_index_path, notice: 'Score was successfully destroyed.'
  end

  private

  def set_score
    @score = Score.find(params[:id])
  end

  def score_params
    params.require(:score).permit(:main_score, :tiebreak_score, :athlete_id, :workout_id, :capped, :cap_score)
  end

  def build_score
    score = Score.new(score_params.except(:cap_score))
    modified_score_params = transform_time_scores_params(score, score_params.dup)
    Score.new(modified_score_params.except(:cap_score))
  end

  def transform_time_scores_params(score, params)
    if score.workout_type == 'Time'
      params[:main_score] = time_to_seconds(params[:main_score])
      params[:main_score] = score.time_cap + params[:cap_score].to_i if params[:capped] == '1'
    end

    params[:tiebreak_score] = time_to_seconds(params[:tiebreak_score]) if score.tiebreak_type == 'Time'

    params
  end
end
