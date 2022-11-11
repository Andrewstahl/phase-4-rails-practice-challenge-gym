class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    render json: Membership.all
  end

  def show
    render json: @membership
  end

  def update
    @membership.update!(membership_params)
    render json: @membership

  end

  def create
    membership = Membership.create!(membership_params)
    render json: membership, status: :created
  end

  def destroy
    @membership.destroy!
    head :no_content
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def membership_params
    params.permit(:gym_id, :client_id, :charge)
  end

  def render_record_not_found_response
    render json: { error: "Membership not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
