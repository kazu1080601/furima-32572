class OrdersController < ApplicationController
  def index
     @item = Item.find(params[:item_id])
     @order = Order.new
  end
  
  def create
    binding.pry
  end
end
