class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.float :subtotal
      t.float :total
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
