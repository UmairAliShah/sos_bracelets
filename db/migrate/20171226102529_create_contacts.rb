class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :relation
      t.string :country
      t.string :code
      t.string :number
      t.string :email

      t.timestamps
    end
  end
end
