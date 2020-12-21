class ItemsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @items = Item.all.order(id: "DESC")
    @feebearings = []
    2.times do |i|
      @feebearings[i + 2] = Feebearing.find (i + 2)
    end
    binding.pry
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

  private

  def item_params
    params.require(:item).permit(:image, :name, :text, :category_id, :condition_id, :feebearing_id, :area_id, :preparation_id,
                                 :price).merge(user_id: current_user.id)
  end
end
