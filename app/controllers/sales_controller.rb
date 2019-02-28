class SalesController < ApplicationController
  # GET /sales
  def index
    from = params[:from]
    if from.blank?
      return render json: { error: t('.from_is_blank') },
                    status: :unprocessable_entity
    end

    to = params[:to]
    if to.blank?
      return render json: { error: t('.to_is_blank') },
                    status: :unprocessable_entity
    end

    begin
      date_format = '%Y-%m-%d'
      from = Date.strptime(from, date_format)
      to = Date.strptime(to, date_format)
    rescue ArgumentError
      scope = 'activerecord.errors.models.sale.attributes'
      return render json: {
        error: t('date.invalid', scope: scope)
      }, status: :unprocessable_entity
    end
    if from > to
      return render json: {
        error: t('.from_greater_than_to')
      }, status: :unprocessable_entity
    end

    sales = Sale.where(date_of_sale: from..to)
                .select(:good_id, :price)
                .group(:good_id)
                .sum(:price)
    total_revenue = 0
    goods = Good.select(:id, :title)
                .where(id: sales.keys)
                .order(:title).map do |good|
      revenue = sales[good.id]
      total_revenue += revenue
      {
        title: good.title,
        revenue: revenue
      }
    end
    render json: {
      from: from,
      to: to,
      goods: goods,
      total_revenue: total_revenue.round(2)
    }
  end
end
