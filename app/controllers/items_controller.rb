class ItemsController < ApplicationController
  def index
  end

  def new
    if user_signed_in?
      @item = Item.new
    else
      redirect_to root_path
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      redirect_to new_user_session_path
    else
      @item = item
      render :new
    end
  end


  private
  def item_params
    params.require(:item).permit(:name, :text, :category_id, :condition_id, :feebearing_id, :area_id, :preparation_id, :price).merge(user_id: current_user.id)
  end

end
