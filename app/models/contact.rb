class Contact < ApplicationRecord
  validates :name, presence: true
  validates :country, presence: true
  validates :code, presence: true
  validates :number, presence:true


  belongs_to :contactable, polymorphic: true
end
