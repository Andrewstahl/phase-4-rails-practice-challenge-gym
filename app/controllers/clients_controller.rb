class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_not_found_response

  def index
    render json: Client.all
  end

  def show
    render json: @client
  end

  def create
    @client = Client.create!(client_parms)
    render json: @client, status: :created
  end

  def update
    @client.update!(client_parms)
    render json: @client
  end

  def destroy
    @client.destroy!
    head :no_content
  end    
  
  private
  
  def set_client
    @client = Client.find(params[:id])
  end

  def client_parms
    params.permit(:name, :age)
  end

  def render_record_not_found_response
    render json: { error: "Client not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
