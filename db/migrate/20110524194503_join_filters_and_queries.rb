class JoinFiltersAndQueries < ActiveRecord::Migration

  def self.up
    create_table :filters_queries, :id => false do |t|
      t.integer :filter_id
      t.integer :query_id
    end
    add_index(:filters_queries, [:filter_id, :query_id], :unique => true)
  end

  def self.down
    drop_table :filters_queries
  end

end
