class GymsController < ApplicationController
  before_action :set_gym, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    render json: Gym.all
  end

  def show
    render json: @gym
  end

  def update
    @gym.update!(gym_params)
    render json: @gym
  end

  def create
    @gym = Gym.create!(gym_params)
    render json: @gym
  end

  def destroy
    @gym.destroy!
    head :no_content
  end

  private

  def set_gym
    @gym = Gym.find(params[:id])
  end

  def gym_params
    params.permit(:name, :address)
  end

  def render_record_not_found_response
    render json: { error: "Gym not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
