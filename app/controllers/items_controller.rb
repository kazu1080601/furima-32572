class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :purchase_check, only: [:index, :show]

  def index
    @items = Item.all.order(id: 'DESC')
    @purchases = Purchase.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path if current_user.id != @item.user.id
  end

  def update
    if (current_user.id == @item.user.id) && @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if (current_user.id == @item.user.id) && @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :text, :category_id, :condition_id, :feebearing_id, :area_id, :preparation_id,
                                 :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def purchase_check
    purchases = Purchase.all
    @purchase_check = []
    purchases.each do |purchase|
      @purchase_check << purchase.item_id
    end
  end

end
