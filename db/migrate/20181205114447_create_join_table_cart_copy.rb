# frozen_string_literal: true

class CreateJoinTableCartCopy < ActiveRecord::Migration[5.2]
  def change
    create_join_table :carts, :copies do |t|
      # t.index [:cart_id, :copy_id]
      # t.index [:copy_id, :cart_id]
    end
  end
end
