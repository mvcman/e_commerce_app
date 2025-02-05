class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def total_price 
    product.price * quantity 
  end
end
