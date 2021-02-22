class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
  end

  def new
    if user_signed_in?
      @item = Item.new
    else
      redirect_to action: :index 
    end
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:image, :item_name, :item_text, :category_id, :status_id, :deliveryfee_id, :area_id, :days_id, :price).merge(user_id: current_user.id)
  end

end
