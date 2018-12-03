class CreateCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :copies do |t|
      t.belongs_to :user
      t.belongs_to :game
      t.boolean :available
      t.string :address
      t.date :return
      t.timestamps
    end
  end
end
