class CartsController < ApplicationController
    before_action :require_authentication
    before_action :set_cart, only: [:show, :add_item]

    def show 
    end 

    def add_item 
        product = Product.find(params[:product_id])
        cart_item = @cart.cart_items.find_or_initialize_by(product: product)
        if cart_item
            cart_item.quantity = 1
        else
            cart_item.quantity += 1
        end
        cart_item.save 
        redirect_to cart_path
    end

    def remove_item 
        cart_item = CartItem.find(params[:id])
        cart_item.destroy 
        redirect_to cart_path
    end

    def update_item
        cart_item = CartItem.find(params[:id]) 
        if cart_item.present?
            quantity = cart_item.quantity 
            if params[:op].present? && params[:op] == "add"
                quantity += 1 
                cart_item.update(quantity: quantity)
            else 
                quantity -= 1 
                if quantity <= 0
                    cart_item.destroy
                else
                    cart_item.update(quantity: quantity)
                end
            end
        end
        redirect_to cart_path
    end

    private 
    
    def set_cart 
        @cart = Current.user.cart || Current.user.create_cart
    end 
end 