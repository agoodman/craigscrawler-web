class CreateSubregions < ActiveRecord::Migration
  def self.up
    create_table :subregions do |t|
      t.integer :region_id
      t.string :code
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :subregions
  end
end
