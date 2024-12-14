class ProductsController < ApplicationController 
    before_action :require_authentication
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :set_categories, only: [:new, :edit]

    def index 
        @products = Product.includes(:category).group_by(&:category)
        @my_products = Current.user.products
    end 

    def show 
    end 

    def new 
        @product = Current.user.products.new
    end

    def edit 
    end

    def create 
        @product = Current.user.products.new(product_params)
        respond_to do |format|
            if @product.save
                format.html { redirect_to products_path, notice: "Created!" }
            else 
                format.html { redirect_to products_path, notice: "Failed to Create!" }
            end
        end 
    end

    def update 
        respond_to do |format|
            if @product.update(product_params)
                format.html { redirect_to products_path, notice: "Updated!" }
            else 
                format.html { redirect_to products_path, notice: "Failed to Update!" }
            end
        end 
    end 

    def destroy 
        respond_to do |format|
            if @product.destroy
                format.html { redirect_to products_path, notice: "Destroyed!" }
            else 
                format.html { redirect_to products_path, notice: "Failed to Destroy!" }
            end
        end 
    end

    def destroy_image 
        image = ActiveStorage::Attachment.find(params[:id])
        respond_to do |format|
            if image.purge
                format.html { redirect_to product_path(image.record), notice: "Image deleted successfully!" }
            else 
                format.html { redirect_to product_path(image.record), notice: "Failed to delete image!" }
            end
        end
    end

    private 

    def set_product 
        @product = Product.find(params[:id])
    end

    def product_params 
        params.require(:product).permit(:name, :description, :price, :stock, :category_id, images: [])
    end

    def set_categories
        @categories = Category.all 
    end
end 
