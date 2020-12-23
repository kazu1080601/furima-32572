class OrdersController < ApplicationController
  before_action :set_item

  def index
     @order = Order.new
  end
  
  def create
    binding.pry
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
    params.require(:order).permit(:post_number, :area_id, :municipality, :address, :building, :phone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end


