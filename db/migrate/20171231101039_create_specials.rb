class CreateSpecials < ActiveRecord::Migration[5.1]
  def change
    create_table :specials do |t|
      t.string :name
      t.string :notes

      t.timestamps
    end
  end
end
