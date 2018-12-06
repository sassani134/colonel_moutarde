class AddColumnLatLongToCopy < ActiveRecord::Migration[5.2]
  def change
    add_column :copies, :latitude, :float
    add_column :copies, :longitude, :float
  end
end
