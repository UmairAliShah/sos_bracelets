class Address < ApplicationRecord
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true

  belongs_to :addressble, polymorphic: true
end
