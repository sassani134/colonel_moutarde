class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.belongs_to :game
      t.belongs_to :player_number
      t.belongs_to :style
      t.belongs_to :genre
      t.belongs_to :age
      t.timestamps
    end
  end
end
