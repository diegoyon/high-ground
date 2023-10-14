# frozen_string_literal: true

class FriAthletesController < ApplicationController
  before_action :set_athlete, only: %i[show edit update destroy]

  include FriActions

  def index
    @athletes = Athlete.all
  end

  def show; end

  def new
    @athlete = Athlete.new
    @athlete.build_payment(paymentable: FriCheckout.new)
  end

  def edit; end

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

  def update
    if @athlete.update(athlete_params)
      redirect_to athlete_url(@athlete), notice: 'Athlete was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @athlete.destroy

    redirect_to athletes_url, notice: 'Athlete was successfully destroyed.'
  end

  private

  def set_athlete
    @athlete = Athlete.find(params[:id])
  end

  def athlete_params
    params.require(:athlete).permit(:first_name, :last_name, :email, :phone, :tshirt_size, :tshirt_name, :box,
                                    :division, payment_attributes: [paymentable_attributes: [:fri_username]])
  end
end
