class CreateGameComments < ActiveRecord::Migration[5.2]
  def change
    create_table :game_comments do |t|
      t.string :Game
      t.string :Comment
      t.belongs_to :user, index: true
      t.text :content
      t.timestamps
    end
  end
end
