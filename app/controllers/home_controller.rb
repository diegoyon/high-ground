# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def success; end

  def payment_completed
    return unless params[:checkout_id]

    @athlete = RecurrenteCheckout.find_by(checkout_id: params[:checkout_id]).payment.athlete
    @athlete&.payment&.update(payment_status: 'completed')
  end

  def payment_failed
    return unless params[:checkout_id]

    @athlete = RecurrenteCheckout.find_by(checkout_id: params[:checkout_id]).payment.athlete
    @athlete&.payment&.update(payment_status: 'failed')
  end

  def payment_options; end
end
