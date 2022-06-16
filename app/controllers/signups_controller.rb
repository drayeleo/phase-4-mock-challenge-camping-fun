class SignupsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

  def create
    signup = Signup.create!(permitted_params)
    render json: signup.activity, status: :created
  end

  private

  def permitted_params
    params.permit(:time, :camper_id, :activity_id)
  end

  def handle_record_invalid(exception)
    render json: {
             errors: exception.record.errors.full_messages
           },
           status: :unprocessable_entity
  end
end
