class CreateBloods < ActiveRecord::Migration[5.1]
  def change
    create_table :bloods do |t|
      t.string :name

      t.timestamps
    end
  end
end
