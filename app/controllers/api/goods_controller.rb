class Api::GoodsController < Api::ApiController
  before_action :authenticate_api_user!, only: %i[create update destroy]
  before_action :set_good, only: %i[show edit update destroy sales sale]

  # GET /api/goods
  def index
    @goods = Good.order(:title)
  end

  # GET /api/goods/1
  def show; end

  # GET /api/goods/new
  def new
    @good = Good.new
  end

  # GET /api/goods/1/edit
  def edit; end

  # POST /api/goods
  def create
    @good = Good.new(good_params)
    unless @good.valid?
      return render json: @good.errors, status: :unprocessable_entity
    end

    Good.transaction do
      return render :show, status: :created if @good.save && add_new_good_params

      raise ActiveRecord::Rollback
    end
    render json: @good.errors, status: :unprocessable_entity
  end

  # PATCH/PUT /api/goods/1
  def update
    Good.transaction do
      if @good.update(good_params) && update_good_params
        return render :show, status: :ok
      end

      raise ActiveRecord::Rollback
    end
    render json: @good.errors, status: :unprocessable_entity
  end

  # DELETE /api/goods/1
  def destroy
    @good.destroy
    head :no_content
  end

  # GET /api/goods/:id/sales
  def sales
    @sales = @good.sales
  end

  # GET /api/goods/:id/sales/:sale_id
  def sale
    @sale = @good.sales.find(params[:sale_id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_good
    @good = Good.find(params[:id])
  end

  # Never trust parameters from the scary internet
  def good_params
    params.permit(:title)
  end

  def sale_params
    params.permit(sales: %i[id date_of_sale price _destroy])
  end

  def add_new_good_params
    new_params = sale_params[:sales]
    return true if new_params.blank?

    @good.sales.create(new_params)
    @good.valid?
  end

  def update_good_params
    new_params = sale_params[:sales]
    return true if new_params.blank?

    begin
      new_params.each do |param|
        id = param[:id]
        if id.blank?
          @good.sales.create!(
            date_of_sale: param[:date_of_sale],
            price: param[:price]
          )
        else
          sale = @good.sales.find(id)
          if param[:_destroy]
            @good.sales.destroy sale
          else
            sale.update!(
              date_of_sale: param[:date_of_sale],
              price: param[:price]
            )
          end
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      @good.errors.add(:error, e)
      return false
    rescue ActiveRecord::RecordInvalid => e
      @good.errors.add(:error, e)
      return false
    end
    true
  end
end
