class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.date :dob
      t.string :gender
      t.string :code
      t.string :country
      t.string :phone
      t.string :blood
      t.string :hair
      t.string :eye
      t.string :height
      t.float :weight

      t.timestamps
    end
  end
end
