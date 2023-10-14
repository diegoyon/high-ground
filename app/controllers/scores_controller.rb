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
    if @score.update(modified_score_params)
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
    params.require(:score).permit(:submitted_score, :tiebreak_score, :athlete_id, :workout_id, :capped, :cap_score)
  end

  def build_score
    score = Score.new(score_params)
    modified_score_params = transform_time_scores_params(score, score_params.dup)
    Score.new(modified_score_params)
  end

  def transform_time_scores_params(score, params)
    if params[:capped] == '1'
      params = scores_if_capped(score, params)
    elsif score.workout_type == 'Time'
      params = scores_if_not_capped(score, params)
    else
      params[:main_score] = params[:submitted_score]
    end
    params[:tiebreak_score] = transform_tiebreak_time_score_params(params) if score.tiebreak_type == 'Time'
    params
  end

  def scores_if_capped(score, params)
    params[:main_score] = score.time_cap + params[:cap_score].to_i
    params[:submitted_score] = score.time_cap
    params
  end

  def scores_if_not_capped(score, params)
    params[:main_score] = transform_main_time_score_params(score, params)
    params[:submitted_score] = time_to_seconds(params[:submitted_score]) if params[:submitted_score].present?
    params
  end

  def transform_main_time_score_params(score, params)
    return if params[:submitted_score].blank?

    params[:main_score] = time_to_seconds(params[:submitted_score])
    params[:main_score] = score.time_cap + params[:cap_score].to_i if params[:capped] == '1'
    params[:main_score]
  end

  def transform_tiebreak_time_score_params(params)
    return if params[:tiebreak_score].blank?

    time_to_seconds(params[:tiebreak_score])
  end
end
