class AddColumnToOrderRented < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :rented, :boolean, array: true, default: []
  end
end
