# frozen_string_literal: true

class RecurrenteAthletesController < ApplicationController
  before_action :set_athlete, only: %i[show edit update destroy]

  # GET /athletes or /athletes.json
  def index
    @athletes = Athlete.all
  end

  # GET /athletes/1 or /athletes/1.json
  def show; end

  # GET /athletes/new
  def new
    @athlete = Athlete.new
  end

  # GET /athletes/1/edit
  def edit; end

  # POST /athletes or /athletes.json
  def create
    @athlete = Athlete.new(athlete_params)
    if @athlete.valid?
      recurrente_user_id = get_recurrente_user_id(@athlete.full_name, @athlete.email)
      create_recurrente_checkout(recurrente_user_id)
      create_payment
      redirect_to_checkout
      # recurrente_user = create_recurrente_user(@athlete.full_name, @athlete[:email])
      # checkout_data = create_checkout(recurrente_user)
      # checkout_id = checkout_data['id']
      # recurrente_checkout = RecurrenteCheckout.create(checkout_id:)
      # @athlete.build_payment(payment_status: 'pending', paymentable: recurrente_checkout)
      # checkout_url = checkout_data['checkout_url']
      # @athlete.save
      # redirect_to checkout_url, allow_other_host: true
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

  # Only allow a list of trusted parameters through.
  def athlete_params
    params.require(:athlete).permit(:first_name, :last_name, :email, :phone, :tshirt_size, :box, :division)
  end

  def get_recurrente_user_id(name, email)
    public_key = Rails.application.credentials.dig(:all_environments, :recurrente, :public_key)
    secret_key = Rails.application.credentials.dig(:all_environments, :recurrente, :secret_key)
    api_response_create_user = create_recurrente_user(name, email, public_key, secret_key)
    api_data = JSON.parse(api_response_create_user.body)
    api_data['id']
  end

  def create_recurrente_user(name, email, public_key, secret_key)
    HTTParty.post('https://app.recurrente.com/api/users', {
                    body: { email:, full_name: name }.to_json,
                    headers: {
                      'Content-Type' => 'application/json',
                      'X-PUBLIC-KEY' => public_key,
                      'X-SECRET-KEY' => secret_key
                    }
                  })
  end

  def create_recurrente_checkout(recurrente_user_id)
    checkout_data = create_checkout(recurrente_user_id)
    checkout_id = checkout_data['id']
    @recurrente_checkout = RecurrenteCheckout.create(checkout_id:)
  end

  def create_checkout(user_id)
    public_key = Rails.application.credentials.dig(:all_environments, :recurrente, :public_key)
    secret_key = Rails.application.credentials.dig(:all_environments, :recurrente, :secret_key)
    api_response_create_checkout = HTTParty.post('https://app.recurrente.com/api/checkouts', {
                                                   body: { items:
                                                     [{
                                                       price_id: 'prod_xrhjrg0h'
                                                     }],
                                                           user_id: }.to_json,
                                                   headers: { 'Content-Type' => 'application/json',
                                                              'X-PUBLIC-KEY' => public_key, 'X-SECRET-KEY' => secret_key }
                                                 })
    JSON.parse(api_response_create_checkout.body)
  end
end
