# frozen_string_literal: true

class ScoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_score, only: %i[show edit update destroy]

  # GET /scores or /scores.json
  def index
    @scores = Score.all
  end

  # GET /scores/1 or /scores/1.json
  def show; end

  # GET /scores/new
  def new
    @score = Score.new
    @score.athlete = Athlete.find(params[:athlete_id])
    @score.workout = Workout.find(params[:workout_id])
  end

  # GET /scores/1/edit
  def edit; end

  # POST /scores or /scores.json
  def create
    modified_score_params = score_params.dup.except(:cap_score)
    @score = Score.new(modified_score_params)

    if @score.workout_type == 'Time'
      minutes, seconds = modified_score_params[:main_score].split(':')
      modified_score_params[:main_score] = minutes.to_i * 60 + seconds.to_i
      if score_params[:cap_score].present?
        modified_score_params[:main_score] =
          @score.time_cap + score_params[:cap_score].to_i
      end
      @score = Score.new(modified_score_params)
    end

    if @score.has_tiebreak? && @score.tiebreak_type == 'Time'
      minutes, seconds = modified_score_params[:tiebreak_score].split(':')
      modified_score_params[:tiebreak_score] = minutes.to_i * 60 + seconds.to_i
      @score = Score.new(modified_score_params)
    end

    respond_to do |format|
      if @score.save
        format.html { redirect_to admin_leaderboard_index_path, notice: 'Score was successfully created.' }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1 or /scores/1.json
  def update
    modified_score_params = score_params.dup.except(:cap_score)

    if @score.workout_type == 'Time'
      minutes, seconds = modified_score_params[:main_score].split(':')
      modified_score_params[:main_score] = minutes.to_i * 60 + seconds.to_i
      if score_params[:cap_score].present?
        modified_score_params[:main_score] =
          @score.time_cap + score_params[:cap_score].to_i
      end
    end

    if @score.has_tiebreak? && @score.tiebreak_type == 'Time'
      minutes, seconds = modified_score_params[:tiebreak_score].split(':')
      modified_score_params[:tiebreak_score] = minutes.to_i * 60 + seconds.to_i
    end

    if @score.update(modified_score_params)
      redirect_to admin_leaderboard_index_path, notice: 'Score was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /scores/1 or /scores/1.json
  def destroy
    @score.destroy

    respond_to do |format|
      format.html { redirect_to admin_leaderboard_index_path, notice: 'Score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_score
    @score = Score.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def score_params
    params.require(:score).permit(:main_score, :tiebreak_score, :athlete_id, :workout_id, :capped, :cap_score)
  end
end
