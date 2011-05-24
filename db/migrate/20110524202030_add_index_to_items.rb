class AddIndexToItems < ActiveRecord::Migration

  def self.up
    add_index(:items, :feed_id)
  end

  def self.down
    remove_index(:items, :feed_id)
  end
  
end
