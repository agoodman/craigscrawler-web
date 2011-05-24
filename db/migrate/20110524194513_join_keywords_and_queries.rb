class JoinKeywordsAndQueries < ActiveRecord::Migration

  def self.up
    create_table :keywords_queries, :id => false do |t|
      t.integer :keyword_id
      t.integer :query_id
    end
    add_index(:keywords_queries, [:keyword_id, :query_id], :unique => true)
  end

  def self.down
    drop_table :keywords_queries
  end
  
end
