# frozen_string_literal: true

module FilterActions
  extend ActiveSupport::Concern

  private

  def filter_athletes
    @athletes = @athletes.where(division: params[:division].presence || 'Scaled Femenino')
  end

  def search_athletes
    return if params[:query].blank?

    @athletes = @athletes.where('lower(first_name || \' \' || last_name) LIKE :query',
                                query: "%#{params[:query].downcase}%")
  end
end
