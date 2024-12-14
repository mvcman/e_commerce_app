class Product < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many_attached :images

  validates :name, :price, :stock, :category_id, presence: true

  # validates :images, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes, message: "is too large. Each file must be less than 5MB."}

  validate :validate_images

  def is_editable?
    creator == Current.user
  end

  private 

  def validate_images 
    images.each do |image|
      if !image.content_type.in?(%w[image/png image/jpg image/jpeg])
        errors.add(:images, "must be a PNG, JPG, or,JPEF file")
      elsif image.byte_size > 5.megabytes 
        errors.add(:images, 'is too large. Each file must be less than 5MB')
      end
    end
  end
end
