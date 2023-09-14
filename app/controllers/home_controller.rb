class HomeController < ApplicationController
  def index
  end

  def success
  end

  def payment_completed
    @recurrente_athlete = RecurrenteAthlete.find_by(checkout_id: params[:checkout_id])
    @recurrente_athlete&.update(payment_status: 'completed')
  end

  def payment_failed
    @recurrente_athlete = RecurrenteAthlete.find_by(checkout_id: params[:checkout_id])
    @recurrente_athlete&.update(payment_status: 'failed')
  end
end
