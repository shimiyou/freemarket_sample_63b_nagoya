class ItemsController < ApplicationController
  before_action :set_all, only: [:new, :create, :edit, :update]

  before_action :set_item, only: [:show, :edit]

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
  def set_item
    @item = Item.find(params[:id])
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :size_id, :state_id, :postage_side_id, :send_method_id, :prefecture_id, :send_date_id, :price, item_images_attributes: [:image_url]).to_h
  end



  # {"name"=>"モンサンミッシェル",
  #   "description"=>"n",
  #   "category_id"=>"3",
  #   "size_id"=>"2",
  #   "state_id"=>"5",
  #   "postage_side_id"=>"2",
  #   "send_method_id"=>"2",
  #   "prefecture_id"=>"3",
  #   "send_date_id"=>"3",
  #   "price"=>"3000",
  #   "item_images_attributes"=>
  #    {"0"=>
  #      {"image_url"=>
  #        #<ActionDispatch::Http::UploadedFile:0x00007fd019f99200
  #         @content_type="image/jpeg",
  #         @headers=
  #          "Content-Disposition: form-data; name=\"item[item_images_attributes][0][image_url]\"; filename=\"\xE3\x83\xA2\xE3\x83\xB3\xE3\x82\xB5\xE3\x83\xB3\xE3\x83\x9F\xE3\x83\x83\xE3\x82\xB7\xE3\x82\xA7\xE3\x83\xAB.jpg\"\r\nContent-Type: image/jpeg\r\n",
  #         @original_filename="モンサンミッシェル.jpg",
  #         @tempfile=#<File:/var/folders/sv/_dkg41752vqg350kr4g9fs940000gn/T/RackMultipart20191202-91578-1d1ny31.jpg>>}}}

          


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
