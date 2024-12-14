class OrdersController < ApplicationController
    before_action :require_authentication

    def index 
        @orders = Current.user.orders.all
    end

    def show 
        @order = Current.user.orders.find(params[:id])
    end

    def create 
        cart = Current.user.cart 
        if order = Current.user.orders.create(status: 0, total: cart.total_price)
            cart.cart_items.each do |item|
                order.order_items.create(
                    product: item.product,
                    quantity: item.quantity,
                    price: item.product.price
                )
            end 
            cart.cart_items.destroy_all
        end

        redirect_to order_path(order), notice: "Order placed successfully!"
    end
end