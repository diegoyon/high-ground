class RecurrenteAthletesController < ApplicationController
  before_action :set_athlete, only: %i[ show edit update destroy ]

  # GET /athletes or /athletes.json
  def index
    @recurrente_athletes = RecurrenteAthlete.all
  end

  # GET /athletes/1 or /athletes/1.json
  def show
  end

  # GET /athletes/new
  def new
    @recurrente_athlete = RecurrenteAthlete.new
  end

  # GET /athletes/1/edit
  def edit
  end

  # POST /athletes or /athletes.json
  def create
    @recurrente_athlete = RecurrenteAthlete.new(recurrente_athlete_params)
    if @recurrente_athlete.valid?
      recurrente_user = create_recurrente_user("#{@recurrente_athlete[:first_name]} #{@recurrente_athlete[:last_name]}", @recurrente_athlete[:email])
      checkout_url = create_checkout(recurrente_user)
      @recurrente_athlete.save
      redirect_to checkout_url, allow_other_host: true
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /athletes/1 or /athletes/1.json
  def update
    respond_to do |format|
      if @recurrente_athlete.update(athlete_params)
        format.html { redirect_to recurrente_athlete_url(@recurrente_athlete), notice: "Athlete was successfully updated." }
        format.json { render :show, status: :ok, location: @athlete }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /athletes/1 or /athletes/1.json
  def destroy
    @recurrente_athlete.destroy

    respond_to do |format|
      format.html { redirect_to recurrente_athletes_url, notice: "Athlete was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurrente_athlete
      @recurrente_athlete = RecurrenteAthlete.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recurrente_athlete_params
      params.require(:recurrente_athlete).permit(:first_name, :last_name, :email, :phone, :tshirt_size, :box, :division)
    end

    def create_recurrente_user(name, email)
      public_key = Rails.application.credentials.dig(:all_environments, :recurrente, :public_key)
      secret_key = Rails.application.credentials.dig(:all_environments, :recurrente, :secret_key)
      api_response_create_user = HTTParty.post('https://app.recurrente.com/api/users', {
        body: {
          email: email,
          full_name: name
        }.to_json,
        headers: { 'Content-Type' => 'application/json', 'X-PUBLIC-KEY' => public_key, 'X-SECRET-KEY' => secret_key }
      })
      api_data = JSON.parse(api_response_create_user.body)
      userId = api_data['id']
      userId
    end

    def create_checkout(userId)
      public_key = Rails.application.credentials.dig(:all_environments, :recurrente, :public_key)
      secret_key = Rails.application.credentials.dig(:all_environments, :recurrente, :secret_key)
      api_response_create_checkout = HTTParty.post('https://app.recurrente.com/api/checkouts', {
        body: { items: 
          [{
            price_id: "prod_xrhjrg0h",
            user_id: userId
          }] 
          }.to_json,
        headers: { 'Content-Type' => 'application/json', 'X-PUBLIC-KEY' => public_key, 'X-SECRET-KEY' => secret_key }
      })
      api_data = JSON.parse(api_response_create_checkout.body)
      checkout_url = api_data['checkout_url']
      checkout_url
    end
end
