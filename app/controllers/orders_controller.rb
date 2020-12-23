class OrdersController < ApplicationController
  def index
     @item = Item.find(params[:item_id])
     @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order).permit(:post_number, :area_id, :municipality, :address, :building, :phone).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end


