class CreateFilters < ActiveRecord::Migration
  def self.up
    create_table :filters do |t|
      t.integer :feed_id
      t.string :key
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :filters
  end
end
