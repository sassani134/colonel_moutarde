class AddColumnToCartOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :number_week, :integer, array: true, default: []
    add_column :carts, :number_week, :integer, array: true, default: []
    add_column :copies, :rented, :boolean
  end
end