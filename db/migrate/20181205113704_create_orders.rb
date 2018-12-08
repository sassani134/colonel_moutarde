class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.integer :number_week, array: true, default: []
      t.boolean :renting, array: true, default: []
      t.float :price
      t.timestamps
    end
  end
end
