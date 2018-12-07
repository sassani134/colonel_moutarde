class CreateAges < ActiveRecord::Migration[5.2]
  def change
    create_table :ages do |t|
      t.integer :minimum
      t.timestamps
    end
  end
end
