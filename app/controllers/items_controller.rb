class ItemsController < ApplicationController
  before_action :set_all, only: [:index, :new, :create, :show, :edit, :update]
  before_action :set_item, only: [:show, :edit, :destroy, :update,:buy,:pay]
  before_action :set_item_image, only: [:index, :show]
  before_action :set_card, only: [:buy, :pay]
  before_action :set_item_category, only: [:new,:create,:edit,:update]
  require 'payjp'


  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
    @item.item_images.build
    @item.build_brand
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
      params[:item_images]['image'].each do |a|
        @item.item_images.create!(image: a)
      end
      redirect_to root_path
    else
      @item.item_images.build
      @item.build_brand
      render :new
    end
  end

  def show
    @images = @item.item_images
    @items = Item.includes(:user)
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render_to_string new_item_path
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end


  def category
    respond_to do |format|
      format.html
      format.json do
       @children = Category.find(params[:parent_id]).children
       #親ボックスのidから子ボックスのidの配列を作成してインスタンス変数で定義
      end
    end
  end
  
  def buy
    @address_info = current_user.address.prefecture.name + current_user.address.city + current_user.address.house_number + current_user.address.build_number
    @full_name = current_user.last_name + current_user.first_name
    if  @card.blank?
      redirect_to new_card_path
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount: @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    customer: @card.customer_id, #顧客ID
    currency: 'jpy', #日本円
    )
    redirect_to done_item_path #完了画面に移動
  end

  def done
    @item = Item.find(params[:id])
    @item.update( purchaser_id: current_user.id)
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_item_image
    @item_images = ItemImage.includes(:item)
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
      item_images_attributes: [:image],
      brand_attributes: [:id, :name],
      
    ).merge(user_id: current_user.id)
  end

  def set_all
    @size = Size.all
    @state = State.all
    @postage_side = PostageSide.all
    @send_method = SendMethod.all
    @prefecture = Prefecture.all
    @send_date = SendDate.all
  end
  def set_card
    @card = current_user.cards.first
  end
  def set_item_category
    #セレクトボックスの初期値設定
    @parents = ["---"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    Category.where(ancestry: nil).each do |parent|
      @parents << parent.name
    end
  end
end