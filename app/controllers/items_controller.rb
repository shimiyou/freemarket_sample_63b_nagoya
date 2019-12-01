class ItemsController < ApplicationController
  before_action :set_all, only: [:new, :create, :edit, :update]

  def index
    @item = Item.all
  end

  def new
    @item = Item.new
    @item.item_images.build
  end

  def create
    @item = Item.new(item_params)
    #binding.pry
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :size_id, :state_id, :postage_side_id, :send_method_id, :prefecture_id, :send_date_id, :price, item_images_attributes: [:id, :image_url, :item_id]).to_h
  end

  def set_all
    @parents = Category.all.order("id ASC").limit(13)
    @size = Size.all
    @state = State.all
    @postage_side = PostageSide.all
    @send_method = SendMethod.all
    @prefecture = Prefecture.all
    @send_date = SendDate.all
  end
end
