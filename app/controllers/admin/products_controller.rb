class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update, :destroy]


  def index
    @items = Product.all.paginate(page: params[:page], per_page: 3)
  end


  def show
  end


  def new
    @item = Product.new
  end


  def edit
  end


  def create
    @item = Product.new(item_params)

      if @item.save
        flash[:notice] = 'Item was successfully created.'
        redirect_to admin_product_path(@item)

      else
        render 'new'
      end
  end


  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }

      else
        format.html { render :edit }

      end
    end
  end


  def destroy

    if @item.destroy
      flash[:notice] = 'Item was successfully destroyed.'
      redirect_to admin_products_path

    else

    end
  end

  def all_products
    @items = Product.all.paginate(page: params[:page], per_page: 3)
    render :products
  end
  private

    def set_item
      @item = Product.find(params[:id])
    end


    def item_params
      params.require(:product).permit(:title, :price, :description, :img_url)
    end
end
