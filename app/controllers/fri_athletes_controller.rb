class FriAthletesController < ApplicationController
  before_action :set_athlete, only: %i[ show edit update destroy ]

  # GET /athletes or /athletes.json
  def index
    @athletes = Athlete.all
  end

  # GET /athletes/1 or /athletes/1.json
  def show
  end

  # GET /athletes/new
  def new
    @athlete = Athlete.new
    @athlete.build_payment(paymentable: FriCheckout.new)
  end

  # GET /athletes/1/edit
  def edit
  end

  # POST /athletes or /athletes.json
  def create
    @athlete = Athlete.new(athlete_params.except(:payment_attributes))
    fri_checkout = FriCheckout.new(athlete_params[:payment_attributes][:paymentable_attributes])
    @athlete.build_payment(paymentable: fri_checkout)
    if @athlete.valid?
      api_data = request_payment
      if api_data['info']['type'] == 'success'
        @athlete.payment.paymentable.fri_request_payment_response = api_data['responseContent']
        @athlete.payment.payment_status = api_data['responseContent']['transaction']['status']
        @athlete.payment.paymentable.transaction_id = api_data['responseContent']['transaction']['id']
        @athlete.save
        redirect_to success_path, notice: "Hemos recibido tus datos correctamente."
      elsif api_data['info']['type'] == 'error'
        @athlete.errors.add(:base, api_data['info']['message'])
        render :new, status: :unprocessable_entity
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /athletes/1 or /athletes/1.json
  def update
    respond_to do |format|
      if @athlete.update(athlete_params)
        format.html { redirect_to athlete_url(@athlete), notice: "Athlete was successfully updated." }
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
      format.html { redirect_to athletes_url, notice: "Athlete was successfully destroyed." }
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
        payment_attributes: [paymentable_attributes: [:fri_username]]
      )
    end

    def request_payment
      username = Rails.application.credentials.dig(:all_environments, :fri, :username)
      password = Rails.application.credentials.dig(:all_environments, :fri, :password)

      # Login
      api_response_login = HTTParty.post('https://api.negocios.soyfri.com/business/auth/v1/login', {
        body: {
          username: username,
          password: password
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      })
      api_data = JSON.parse(api_response_login.body)
      sessionId = api_data['responseContent']['sessionId']

      # Request payment
      api_response_request_payment = HTTParty.post('https://api.negocios.soyfri.com/business/transactions/v1/requests/send', {
        body: {
          info: {},
          requestContent: {
            friUsername: @athlete.payment.paymentable.fri_username,
            amount: "650",
            reference: "high-ground-#{SecureRandom.hex(4)}",
          }
        }.to_json,
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{sessionId}"
        }
      })

      # Logout
      HTTParty.post('https://api.negocios.soyfri.com/business/auth/v1/logout', {
        body: {
          info: {}
        }.to_json,
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{sessionId}"
        }
      })

      JSON.parse(api_response_request_payment.body)
    end

end
