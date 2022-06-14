class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

  def index
    campers = Camper.all
    render json: campers, each_serializer: CamperIndexSerializer
  end

  def show
    camper = find_camper
    render json: camper
  end

  def create
    camper = Camper.create!(permitted_params)
    render json: camper
  end

  private

  def find_camper
    Camper.find(params[:id])
  end

  def permitted_params
    params.permit(:name, :age)
  end

  def handle_record_not_found
    render json: { error: "Camper not found" }, status: :not_found
  end

  def handle_record_invalid(invalid)
    render json: {
             error: invalid.record.errors.full_messages
           },
           status: :unprocessable_entity
  end
end
