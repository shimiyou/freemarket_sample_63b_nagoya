class ItemsController < ApplicationController
  before_action :set_all, only: [:new, :create, :show, :edit, :update]
  before_action :set_item, only: [:show, :edit]

  def index
    @items = Item.includes(:user)
  end

  def new
    @item = Item.new
    @item.item_images.build
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
  end
  
  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :size_id, :state_id, :postage_side_id, :send_method_id, :prefecture_id, :send_date_id, :price, item_images_attributes: [:image_url]).merge(user_id: current_user.id).to_h
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
