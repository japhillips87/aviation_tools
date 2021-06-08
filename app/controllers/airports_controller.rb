class AirportsController < ApplicationController
  before_action :set_icaos, only: :index

  def visited
    render json: AirportService.new.visited
  end

  def refresh_token
    AirportService.new.refresh_token
    head :ok
  end

  private

  def set_icaos
    @icaos = params[:icaos]
  end
end