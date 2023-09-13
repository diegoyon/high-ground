class HomeController < ApplicationController
  def index
  end

  def success
    p '########################'
    p params[:checkout_id]
  end
end
