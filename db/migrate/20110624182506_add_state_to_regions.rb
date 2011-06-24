class AddStateToRegions < ActiveRecord::Migration

  def self.up
    add_column :regions, :state, :string
  end

  def self.down
    remove_column :regions, :state
  end
  
end
