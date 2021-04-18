class AirportsController < ApplicationController
  before_action :set_icaos, only: :index

  def visited
    render json: AirportService.new.visited
  end

  private

  def set_icaos
    @icaos = params[:icaos]
  end
end