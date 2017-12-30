class CreateAllergies < ActiveRecord::Migration[5.1]
  def change
    create_table :allergies do |t|
      t.string :name
      t.string :note

      t.timestamps
    end
  end
end
