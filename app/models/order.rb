class Order < ApplicationRecord
  belongs_to :user 
  has_many :order_items, dependent: :destroy 

  enum status: { pending: 0, completed: 1 }

  def total_price 
    order_items.sum {|item| item.total_price }
  end
end
