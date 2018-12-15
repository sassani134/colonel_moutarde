# frozen_string_literal: true

class CreateJoinTableOrderCopy < ActiveRecord::Migration[5.2]
  def change
    create_join_table :orders, :copies do |t|
      # t.index [:order_id, :copy_id]
      # t.index [:copy_id, :order_id]
    end
  end
end
