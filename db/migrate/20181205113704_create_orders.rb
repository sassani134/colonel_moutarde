class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.float :price
      t.timestamps
    end
  end
end
