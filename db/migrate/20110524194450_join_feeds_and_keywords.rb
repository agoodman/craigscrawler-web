class JoinFeedsAndKeywords < ActiveRecord::Migration

  def self.up
    create_table :feeds_keywords, :id => false do |t|
      t.integer :feed_id
      t.integer :keyword_id
    end
    add_index(:feeds_keywords, [:feed_id, :keyword_id], :unique => true)
  end

  def self.down
    drop_table :feeds_keywords
  end

end
