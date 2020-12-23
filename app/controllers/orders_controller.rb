class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :purchase_check, only: :index

  def index
    redirect_to root_path if @purchase_check.any? { |t| t == @item.id } || current_user.id == @item.user.id
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order).permit(:post_number, :area_id, :municipality, :address, :building, :phone).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def purchase_check
    purchases = Purchase.all
    @purchase_check = []
    purchases.each do |purchase|
      @purchase_check << purchase.item_id
    end
  end
end
