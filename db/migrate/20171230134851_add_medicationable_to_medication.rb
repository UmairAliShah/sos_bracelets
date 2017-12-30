class AddMedicationableToMedication < ActiveRecord::Migration[5.1]
  def change
    add_reference :medications, :medicationable, polymorphic: true
  end
end
