class OrderItemsController < ApplicationController

  def create
    #debugger
    @order = current_order
    @order_item = @order.order_items.new(order_items_params)
    if @order.save
       session[:order_id] = @order.id
       redirect_to cart_path(id: @order.id)
    else
       redirect_to root_path
    end

  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    if @order_item.update(order_items_params)
       @order_items = @order.order_items
       redirect_to cart_path(id: @order.id)
    else
       redirect_to cart_path(id: @order.id)
    end
  end

  def destroy
    #debugger
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    if @order_item.destroy
       @order_items = @order.order_items
       redirect_to cart_path(id: @order.id)
    else
    end
  end

  private
   def order_items_params
      params.require(:order_item).permit(:product_id, :quantity)
   end
end
