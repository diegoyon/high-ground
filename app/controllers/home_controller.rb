class HomeController < ApplicationController
  def index
  end

  def success
  end

  def payment_completed
    if params[:checkout_id]
      @athlete = RecurrenteCheckout.find_by(checkout_id: params[:checkout_id]).payment.athlete
      @athlete&.payment.update(payment_status: 'completed')
    end
  end

  def payment_failed
    if params[:checkout_id]
      @athlete = RecurrenteCheckout.find_by(checkout_id: params[:checkout_id]).payment.athlete
      @athlete&.payment.update(payment_status: 'failed')
    end
  end

  def payment_options
  end
end
