class Medication < ApplicationRecord
  validates :name, presence: true

  belongs_to :medicationable, polymorphic: true
end
