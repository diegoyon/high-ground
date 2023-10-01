class WorkoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout, only: %i[ show edit update destroy ]

  # GET /workouts or /workouts.json
  def index
    @workouts = Workout.order(:workout_number)
  end

  # GET /workouts/1 or /workouts/1.json
  def show
  end

  # GET /workouts/new
  def new
    @workout = Workout.new
  end

  # GET /workouts/1/edit
  def edit
  end

  # POST /workouts or /workouts.json
  def create
    @workout = Workout.new(workout_params)

    if workout_params[:time_cap].present?
      modified_workout_params = workout_params.dup
      minutes, seconds = modified_workout_params[:time_cap].split(":")
      @workout = Workout.new(modified_workout_params)
    end

    respond_to do |format|
      if @workout.save
        format.html { redirect_to workout_url(@workout), notice: "Workout was successfully created." }
        format.json { render :show, status: :created, location: @workout }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workouts/1 or /workouts/1.json
  def update
    modified_workout_params = workout_params.dup
    
    if modified_workout_params[:time_cap].present?
      minutes, seconds = modified_workout_params[:time_cap].split(":")
      modified_workout_params[:time_cap] = minutes.to_i * 60 + seconds.to_i
    end

    respond_to do |format|
      if @workout.update(modified_workout_params)
        format.html { redirect_to workout_url(@workout), notice: "Workout was successfully updated." }
        format.json { render :show, status: :ok, location: @workout }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1 or /workouts/1.json
  def destroy
    @workout.destroy

    respond_to do |format|
      format.html { redirect_to workouts_url, notice: "Workout was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = Workout.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workout_params
      params.require(:workout).permit(:name, :description, :workout_type, :workout_number, :tiebreak_type, :time_cap)
    end
end
