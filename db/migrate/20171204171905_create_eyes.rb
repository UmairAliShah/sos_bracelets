class CreateEyes < ActiveRecord::Migration[5.1]
  def change
    create_table :eyes do |t|
      t.string :name

      t.timestamps
    end
  end
end
