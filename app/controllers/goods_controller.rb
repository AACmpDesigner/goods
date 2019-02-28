class GoodsController < ApplicationController
  before_action :set_good, only: %i[show edit update destroy]

  # GET /goods
  def index
    @goods = Good.order(:title)
  end

  # GET /goods/1
  def show; end

  # GET /goods/new
  def new
    @good = Good.new
  end

  # GET /goods/1/edit
  def edit; end

  # POST /goods
  def create
    @good = Good.new(good_params)
    return render :new unless @good.valid?

    if @good.save && add_new_good_params
      redirect_to @good, notice: t('.success')
    else
      render :new
    end
  end

  # PATCH/PUT /goods/1
  def update
    if @good.update(good_params) && add_new_good_params
      redirect_to @good, notice: t('.success')
    else
      render :edit
    end
  end

  # DELETE /goods/1
  def destroy
    @good.destroy
    redirect_to goods_url, notice: t('.success')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_good
    @good = Good.find(params[:id])
  end

  # Never trust parameters from the scary internet
  def good_params
    params.require(:good).permit(
      :title, sales_attributes: %i[id date_of_sale price _destroy]
    )
  end

  def new_good_params
    params.require(:good).permit(new_sales_attributes: %i[date_of_sale price])
  end

  def add_new_good_params
    new_params = new_good_params
    return true if new_params.blank?

    @good.sales.create(new_params[:new_sales_attributes].values.map(&:to_h))
    @good.valid?
  end
end
