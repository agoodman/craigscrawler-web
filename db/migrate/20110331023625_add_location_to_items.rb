class AddLocationToItems < ActiveRecord::Migration

  def self.up
    add_column :items, :location, :string
  end

  def self.down
    remove_column :items, :location
  end
  
end
