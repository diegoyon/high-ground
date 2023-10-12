# frozen_string_literal: true

class FriAthletesController < ApplicationController
  before_action :set_athlete, only: %i[show edit update destroy]

  include FriActions

  # GET /athletes or /athletes.json
  def index
    @athletes = Athlete.all
  end

  # GET /athletes/1 or /athletes/1.json
  def show; end

  # GET /athletes/new
  def new
    @athlete = Athlete.new
    @athlete.build_payment(paymentable: FriCheckout.new)
  end

  # GET /athletes/1/edit
  def edit; end

  # POST /athletes or /athletes.json
  def create
    @athlete = Athlete.new(athlete_params.except(:payment_attributes))
    fri_checkout = FriCheckout.new(athlete_params[:payment_attributes][:paymentable_attributes])
    @athlete.build_payment(paymentable: fri_checkout)
    if @athlete.valid?
      process_successful_payment
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /athletes/1 or /athletes/1.json
  def update
    respond_to do |format|
      if @athlete.update(athlete_params)
        format.html { redirect_to athlete_url(@athlete), notice: 'Athlete was successfully updated.' }
        format.json { render :show, status: :ok, location: @athlete }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /athletes/1 or /athletes/1.json
  def destroy
    @athlete.destroy

    respond_to do |format|
      format.html { redirect_to athletes_url, notice: 'Athlete was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_athlete
    @athlete = Athlete.find(params[:id])
  end

  def athlete_params
    params.require(:athlete).permit(:first_name, :last_name, :email, :phone, :tshirt_size, :tshirt_name, :box, :division,
                                    payment_attributes: [paymentable_attributes: [:fri_username]])
  end
end
