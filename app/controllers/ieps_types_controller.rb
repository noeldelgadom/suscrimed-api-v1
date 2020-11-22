class IepsTypesController < ApplicationController
  before_action :set_ieps_type, only: [:show, :update, :destroy]

  # GET /ieps_types
  def index
    @ieps_types = IepsType.all

    render json: @ieps_types
  end

  # GET /ieps_types/1
  def show
    render json: @ieps_type
  end

  # POST /ieps_types
  def create
    @ieps_type = IepsType.new(ieps_type_params)

    if @ieps_type.save
      render json: @ieps_type, status: :created, location: @ieps_type
    else
      render json: @ieps_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ieps_types/1
  def update
    if @ieps_type.update(ieps_type_params)
      render json: @ieps_type
    else
      render json: @ieps_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ieps_types/1
  def destroy
    @ieps_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ieps_type
      @ieps_type = IepsType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ieps_type_params
      params.require(:ieps_type).permit(:percentage)
    end
end
