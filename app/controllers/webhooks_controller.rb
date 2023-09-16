class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def fri
    payload = JSON.parse(request.body.read)
    matching_athlete = Athlete.find_by(transaction_id: payload['id'])

    if matching_athlete
      matching_athlete.payment_status = payload['status']
      matching_athlete.fri_webhook_response = payload
      matching_athlete.save
      render json: { message: 'ok' }
    else
      render json: { message: 'no matching athlete found' }
    end
  end

  def recurrente
    render json: { message: 'ok' }
  end
end
