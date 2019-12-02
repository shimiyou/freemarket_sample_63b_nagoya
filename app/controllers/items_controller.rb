class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit]

  def index
    @item = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new
  end

  def show
  end

  def edit
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
  
end
