# frozen_string_literal: true

class RecurrenteAthletesController < ApplicationController
  before_action :set_athlete, only: %i[show edit update destroy]

  def index
    @athletes = Athlete.all
  end

  def show; end

  def new
    @athlete = Athlete.new
  end

  def edit; end

  def create
    @athlete = Athlete.new(athlete_params)
    if @athlete.valid?
      recurrente_user_id = get_recurrente_user_id(@athlete.full_name, @athlete.email)
      checkout_data = get_recurrente_checkout_data(recurrente_user_id)
      create_payment(@athlete, checkout_data)
      redirect_to checkout_data['checkout_url'], allow_other_host: true
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

    respond_to do |format|
      format.html { redirect_to athletes_url, notice: 'Athlete was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_athlete
    @athlete = Athlete.find(params[:id])
  end

  def athlete_params
    params.require(:athlete).permit(:first_name, :last_name, :email, :phone, :tshirt_size, :box, :division)
  end

  def recurrente_keys
    public_key = Rails.application.credentials.dig(:all_environments, :recurrente, :public_key)
    secret_key = Rails.application.credentials.dig(:all_environments, :recurrente, :secret_key)
    [public_key, secret_key]
  end

  def get_recurrente_user_id(name, email)
    api_response_create_user = create_recurrente_user(name, email)
    api_data = JSON.parse(api_response_create_user.body)
    api_data['id']
  end

  def create_recurrente_user(name, email)
    public_key, secret_key = recurrente_keys
    HTTParty.post('https://app.recurrente.com/api/users', {
                    body: { email:, full_name: name }.to_json,
                    headers: {
                      'Content-Type' => 'application/json',
                      'X-PUBLIC-KEY' => public_key,
                      'X-SECRET-KEY' => secret_key
                    }
                  })
  end

  def get_recurrente_checkout_data(recurrente_user_id)
    api_response_create_checkout = create_checkout(recurrente_user_id)
    JSON.parse(api_response_create_checkout.body)
  end

  def create_checkout(recurrente_user_id)
    public_key, secret_key = recurrente_keys
    HTTParty.post('https://app.recurrente.com/api/checkouts', {
                    body: recurrente_checkout_body(recurrente_user_id),
                    headers: recurrente_checkout_headers(public_key, secret_key)
                  })
  end

  def recurrente_checkout_headers(public_key, secret_key)
    {
      'Content-Type' => 'application/json',
      'X-PUBLIC-KEY' => public_key,
      'X-SECRET-KEY' => secret_key
    }
  end

  def recurrente_checkout_body(recurrente_user_id)
    {
      items: [{
        price_id: 'prod_xrhjrg0h'
      }],
      user_id: recurrente_user_id
    }.to_json
  end

  def create_payment(athlete, checkout_data)
    recurrente_checkout = RecurrenteCheckout.create(checkout_id: checkout_data['id'])
    athlete.build_payment(payment_status: 'pending', paymentable: recurrente_checkout)
    athlete.save
  end
end
