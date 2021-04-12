class MetarsController < ApplicationController
  before_action :set_icaos, only: :index

  def index
    render json: MetarService.new(@icaos).call
  end

  private

  def set_icaos
    @icaos = params[:icaos]
  end
end