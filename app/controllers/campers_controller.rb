class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

  def index
    render json: Camper.all
  end

  def show
    camper = find_record
    render json: camper, serializer: CamperWithActivitiesSerializer
  end

  def create
    camper = Camper.create!(permitted_params)
    render json: camper, status: :created
  end

  private

  def find_record
    Camper.find(params[:id])
  end

  def permitted_params
    params.permit(:name, :age)
  end

  def handle_record_not_found
    render json: { error: "Camper not found" }, status: :not_found
  end

  def handle_record_invalid(exception)
    render json: {
             errors: exception.record.errors.full_messages
           },
           status: :unprocessable_entity
  end
end
