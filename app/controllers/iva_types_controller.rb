class IvaTypesController < ApplicationController
  before_action :set_iva_type, only: [:show, :update, :destroy]

  # GET /iva_types
  def index
    @iva_types = IvaType.all

    render json: @iva_types
  end

  # GET /iva_types/1
  def show
    render json: @iva_type
  end

  # POST /iva_types
  def create
    @iva_type = IvaType.new(iva_type_params)

    if @iva_type.save
      render json: @iva_type, status: :created, location: @iva_type
    else
      render json: @iva_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /iva_types/1
  def update
    if @iva_type.update(iva_type_params)
      render json: @iva_type
    else
      render json: @iva_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /iva_types/1
  def destroy
    @iva_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_iva_type
      @iva_type = IvaType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def iva_type_params
      params.require(:iva_type).permit(:percentage)
    end
end
