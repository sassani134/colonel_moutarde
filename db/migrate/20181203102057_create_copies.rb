# frozen_string_literal: true

class CreateCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :copies do |t|
      t.belongs_to :user
      t.belongs_to :game
      t.boolean :available
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :rented
      t.date :return
      t.timestamps
    end
  end
end
