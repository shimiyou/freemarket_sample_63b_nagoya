class ItemsController < ApplicationController
  before_action :set_all, only: [:index, :new, :create, :show, :edit, :update]
  before_action :set_item, only: [:show, :edit, :destroy]
  before_action :set_item_image, only: [:index, :show]

  def index
    @items = Item.includes(:user)
  end

  def new
    @item = Item.new
    @item.item_images.build
    @item.build_brand
    @parents = ['---']
    Category.where(ancestry: nil).each do |parent|
      @parents << parent.name
    end
  end

  def get_category_children
    @children = Category.find_by(name: params[:parent_name], ancestry: nil).children
  end

  def get_category_grandchildren
    @grandchildren = Category.find(params[:child_id]).children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render_to_string :new
    end
  end

  def show
    @images = @item.item_images
  end

  def edit
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_item_image
    @item_images = ItemImage.all
  end

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :category_id,
      :size_id,
      :state_id,
      :postage_side_id,
      :send_method_id,
      :prefecture_id,
      :send_date_id,
      :price,
      item_images_attributes: [:id, :image],
      brand_attributes: [:id, :name]
    ).merge(user_id: current_user.id).to_h
  end

  def set_all
    @size = Size.all
    @state = State.all
    @postage_side = PostageSide.all
    @send_method = SendMethod.all
    @prefecture = Prefecture.all
    @send_date = SendDate.all
  end
end
