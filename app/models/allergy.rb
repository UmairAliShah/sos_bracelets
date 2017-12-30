class Allergy < ApplicationRecord
  validates :name, presence: true

  belongs_to :allergable, polymorphic: true
end
