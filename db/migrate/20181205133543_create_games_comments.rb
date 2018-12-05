class CreateGamesComments < ActiveRecord::Migration[5.2]
  def change
    create_table :games_comments do |t|
      t.string :title
      t.belongs_to :user, index: true
      t.text :content
      t.timestamps
    end
  end
end
