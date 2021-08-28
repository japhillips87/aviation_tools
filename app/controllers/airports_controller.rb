class AirportsController < ApplicationController
  def index
    render json: Airport.all.map(&:icao)
  end

  def create
    airport = Airport.new(airport_params)
    if airport.save
      render json: airport
    else
      render json: { errors: airport.errors.full_messages }, status: 422
    end
  end

  private

  def airport_params
    params.require(:airport).permit(:icao)
  end
end