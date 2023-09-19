class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def fri
    payload = JSON.parse(request.body.read)
    matching_athlete = FriCheckout.find_by(transaction_id: payload['id']).payment.athlete

    if matching_athlete
      matching_athlete.payment.update(payment_status: payload['status'])
      matching_athlete.payment.paymentable.update(fri_webhook_response: payload)
      render json: { message: 'ok' }
    else
      render json: { message: 'no matching athlete found' }
    end
  end

  def recurrente
    render json: { message: 'ok' }
  end
end
