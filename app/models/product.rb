class Product < ApplicationRecord
  has_many :order_items

  validates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :img_url, presence: true
end
