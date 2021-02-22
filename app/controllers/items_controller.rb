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
    Item.create(item_params)
  end

  private
  def item_params
    params.require(:item).permit(:image, :item_name, :item_text,)
  end

end
