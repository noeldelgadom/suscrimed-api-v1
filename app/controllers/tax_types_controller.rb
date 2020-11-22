class TaxTypesController < ApplicationController
  before_action :set_tax_type, only: [:show, :update, :destroy]

  # GET /tax_types
  def index
    @tax_types = TaxType.all

    render json: @tax_types
  end

  # GET /tax_types/1
  def show
    render json: @tax_type
  end

  # POST /tax_types
  def create
    @tax_type = TaxType.new(tax_type_params)

    if @tax_type.save
      render json: @tax_type, status: :created, location: @tax_type
    else
      render json: @tax_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tax_types/1
  def update
    if @tax_type.update(tax_type_params)
      render json: @tax_type
    else
      render json: @tax_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tax_types/1
  def destroy
    @tax_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax_type
      @tax_type = TaxType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tax_type_params
      params.require(:tax_type).permit(:name, :iva_type_id, :ieps_type_id)
    end
end
