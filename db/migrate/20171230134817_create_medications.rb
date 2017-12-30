class CreateMedications < ActiveRecord::Migration[5.1]
  def change
    create_table :medications do |t|
      t.string :name
      t.string :dosage
      t.string :frequency
      t.string :notes

      t.timestamps
    end
  end
end
