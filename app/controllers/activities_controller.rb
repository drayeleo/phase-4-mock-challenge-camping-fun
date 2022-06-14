class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    activities = Activity.all
    render json: activities
  end

  def destroy
    activity = Activity.find(params[:id])
    activity.destroy
    head :no_content
  end

  private

  def handle_record_not_found
    render json: { errors: "Activity not found" }, status: :not_found
  end
end
