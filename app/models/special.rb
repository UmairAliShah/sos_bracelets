class Special < ApplicationRecord
  validates :name, presence: true

  belongs_to :specialable, polymorphic: true
end
