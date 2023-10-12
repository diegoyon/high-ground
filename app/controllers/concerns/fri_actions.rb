# frozen_string_literal: true

module FriActions
  extend ActiveSupport::Concern

  def process_successful_payment
    api_data = request_payment
    if api_data['info']['type'] == 'success'
      update_athlete_after_successful_payment(api_data)
      redirect_to success_path, notice: 'Hemos recibido tus datos correctamente.'
    else
      @athlete.errors.add(:base, api_data['info']['message'])
      render :new, status: :unprocessable_entity
    end
  end

  private

  def update_athlete_after_successful_payment(api_data)
    @athlete.payment.paymentable.fri_request_payment_response = api_data['responseContent']
    @athlete.payment.payment_status = api_data['responseContent']['transaction']['status']
    @athlete.payment.paymentable.transaction_id = api_data['responseContent']['transaction']['id']
    @athlete.save
  end

  def request_payment
    session_id = login_to_fri_api
    payment_response = send_payment_request(session_id)
    logout_from_fri_api(session_id)
    JSON.parse(payment_response.body)
  end

  def login_to_fri_api
    response = HTTParty.post('https://api.negocios.soyfri.com/business/auth/v1/login', {
                               body: {
                                 username: Rails.application.credentials.dig(:all_environments, :fri, :username),
                                 password: Rails.application.credentials.dig(:all_environments, :fri, :password)
                               }.to_json,
                               headers: { 'Content-Type' => 'application/json' }
                             })
    api_data = JSON.parse(response.body)
    api_data['responseContent']['sessionId']
  end

  def send_payment_request(session_id)
    payment_request = build_payment_request(session_id)
    HTTParty.post('https://api.negocios.soyfri.com/business/transactions/v1/requests/send', payment_request)
  end

  def build_payment_request(session_id)
    athlete = @athlete.payment.paymentable
    {
      body: payment_request_body(athlete),
      headers: payment_request_headers(session_id)
    }
  end

  def payment_request_body(athlete)
    {
      info: {},
      requestContent: {
        friUsername: athlete.fri_username,
        amount: '650',
        reference: "high-ground-#{SecureRandom.hex(4)}"
      }
    }.to_json
  end

  def payment_request_headers(session_id)
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{session_id}"
    }
  end

  def logout_from_fri_api(session_id)
    HTTParty.post('https://api.negocios.soyfri.com/business/auth/v1/logout', {
                    body: { info: {} }.to_json,
                    headers: {
                      'Content-Type' => 'application/json',
                      'Authorization' => "Bearer #{session_id}"
                    }
                  })
  end
end
