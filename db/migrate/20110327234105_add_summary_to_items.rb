class AddSummaryToItems < ActiveRecord::Migration

  def self.up
    add_column :items, :summary, :text
  end

  def self.down
    remove_column :items, :summary
  end
  
end
