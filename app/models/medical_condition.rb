class MedicalCondition < ApplicationRecord
  validates :condition, presence: true

  belongs_to :conditionable, polymorphic: true
end
