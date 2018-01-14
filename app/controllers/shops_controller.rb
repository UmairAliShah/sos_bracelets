class ShopsController < ApplicationController
  def index
    @items = Product.all.paginate(page: params[:page], per_page: 4)
    @order_item = current_order.order_items.new
  end
end
