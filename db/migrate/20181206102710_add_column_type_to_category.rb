class AddColumnTypeToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :age, :string
    add_column :categories, :style, :string

  end
end
