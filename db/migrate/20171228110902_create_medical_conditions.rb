class CreateMedicalConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :medical_conditions do |t|
      t.string :condition
      t.string :note

      t.timestamps
    end
  end
end
