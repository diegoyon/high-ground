class AthletesController < ApplicationController
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
  end

  # GET /athletes/1/edit
  def edit
  end

  # POST /athletes or /athletes.json
  def create
    username = Rails.application.credentials.dig(:all_environments, :fri, :username)
    password = Rails.application.credentials.dig(:all_environments, :fri, :password)

    @athlete = Athlete.new(athlete_params)

    #login
    api_response = HTTParty.post('https://api.negocios.soyfri.com/business/auth/v1/login', {
      body: {
        username: username,
        password: password
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    })

    api_data = JSON.parse(api_response.body)
    sessionId = api_data['responseContent']['sessionId']
    
    #ask for payment
    api_response2 = HTTParty.post('https://api.negocios.soyfri.com/business/transactions/v1/requests/send', {
      body: {
        info: {},
        requestContent: {
          friUsername: "diegoyon",
          amount: "10",
          reference: "high-ground-#{SecureRandom.hex(4)}",
        }
      }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{sessionId}"
      }
    })

    #logout
    HTTParty.post('https://api.negocios.soyfri.com/business/auth/v1/logout', {
      body: {
        info: {}
      }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{sessionId}"
      }
    })

    api_data = JSON.parse(api_response2.body)
    p api_data

    if api_data['info']['type'] == 'success'
      respond_to do |format|
        if @athlete.save
          format.html { redirect_to athlete_url(@athlete), notice: "Athlete was successfully created." }
          format.json { render :show, status: :created, location: @athlete }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @athlete.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
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

    # Only allow a list of trusted parameters through.
    def athlete_params
      params.require(:athlete).permit(:first_name, :last_name, :email, :phone)
    end
end
