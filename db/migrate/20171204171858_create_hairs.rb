class CreateHairs < ActiveRecord::Migration[5.1]
  def change
    create_table :hairs do |t|
      t.string :name

      t.timestamps
    end
  end
end
