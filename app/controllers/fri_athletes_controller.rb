class FriAthletesController < ApplicationController
  before_action :set_fri_checkout, only: %i[ show edit update destroy ]

  # GET /athletes or /athletes.json
  def index
    @fri_checkouts = FriAthlete.all
  end

  # GET /athletes/1 or /athletes/1.json
  def show
  end

  # GET /athletes/new
  def new
    @fri_checkout = FriAthlete.new
  end

  # GET /athletes/1/edit
  def edit
  end

  # POST /athletes or /athletes.json
  def create
    @fri_checkout = FriAthlete.new(fri_checkout_params)
    if @fri_checkout.valid?
      api_data = request_payment
      if api_data['info']['type'] == 'success'
        @fri_checkout.fri_request_payment_response = api_data['responseContent']
        @fri_checkout.payment_status = api_data['responseContent']['transaction']['status']
        @fri_checkout.transaction_id = api_data['responseContent']['transaction']['id']
        @fri_checkout.save
        redirect_to success_path, notice: "Hemos recibido tus datos correctamente."
      elsif api_data['info']['type'] == 'error'
        @fri_checkout.errors.add(:base, api_data['info']['message'])
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
      if @fri_checkout.update(fri_checkout_params)
        format.html { redirect_to fri_checkout_url(@fri_checkout), notice: "Athlete was successfully updated." }
        format.json { render :show, status: :ok, location: @fri_checkout }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fri_checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /athletes/1 or /athletes/1.json
  def destroy
    @fri_checkout.destroy

    respond_to do |format|
      format.html { redirect_to fri_checkouts_url, notice: "Athlete was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fri_checkout
      @fri_checkout = FriAthlete.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fri_checkout_params
      params.require(:fri_checkout).permit(:first_name, :last_name, :email, :phone, :fri_username, :tshirt_size, :box, :division, :tshirt_name)
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
            friUsername: @fri_checkout.fri_username,
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
