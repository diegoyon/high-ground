class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def fri
    payload = JSON.parse(request.body.read)
    matching_athlete = Athlete.find_by(payment_request_id: payload['paymentRequestId'], reference: payload['reference'])

    if matching_athlete
      matching_athlete.payment_status = payload['status']
      matching_athlete.fri_webhook_response = payload
      matching_athlete.save
    else
      p '###########################'
      p 'No matching athlete found'
    end

    render json: { message: 'ok' }
  end
end
