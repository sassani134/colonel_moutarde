# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :user, index: true
      t.integer :number_week, array: true, default: []
      t.timestamps
    end
  end
end
