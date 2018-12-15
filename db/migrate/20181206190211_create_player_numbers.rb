# frozen_string_literal: true

class CreatePlayerNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :player_numbers do |t|
      t.integer :number_low
      t.integer :number_high
      t.timestamps
    end
  end
end
