class AddScopeToFeeds < ActiveRecord::Migration

  def self.up
    add_column :feeds, :scope, :string
  end

  def self.down
    remove_column :feeds, :scope
  end
  
end
