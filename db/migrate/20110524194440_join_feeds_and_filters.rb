class JoinFeedsAndFilters < ActiveRecord::Migration

  def self.up
    create_table :feeds_filters, :id => false do |t|
      t.integer :feed_id
      t.integer :filter_id
    end
    add_index(:feeds_filters, [:feed_id, :filter_id], :unique => true)
  end

  def self.down
    drop_table :feeds_filters
  end

end
