class AddLatitudeLongitudeToRegions < ActiveRecord::Migration

  def self.up
    add_column :regions, :latitude, :float
    add_column :regions, :longitude, :float
  end

  def self.down
    remove_column :regions, :latitude
    remove_column :regions, :longitude
  end

end
