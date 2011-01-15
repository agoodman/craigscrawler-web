class CreateKeywords < ActiveRecord::Migration
  def self.up
    create_table :keywords do |t|
      t.integer :feed_id
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :keywords
  end
end
