class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.string :code
      t.string :cate
      t.string :image_url
      t.timestamps
    end
  end
end
