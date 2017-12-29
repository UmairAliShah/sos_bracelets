class AddConditionableToMedicalCondition < ActiveRecord::Migration[5.1]
  def change
    add_reference :medical_conditions, :conditionable, polymorphic: true, index: { name: 'index_medical_on_conditionable_type_and_id' }
  end
end
