# frozen_string_literal: true

class AddTelephoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :telephone, :string
  end
end
