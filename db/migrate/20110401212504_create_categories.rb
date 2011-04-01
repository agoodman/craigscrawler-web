class CreateCategories < ActiveRecord::Migration

  def self.up
    create_table :categories do |t|
      t.integer :parent_id
      t.string :code
      t.string :title

      t.timestamps
    end
    
    Category.create(:code => 'ccc', :title => 'community')
    Category.create(:code => 'hhh', :title => 'housing')
    Category.create(:code => 'sss', :title => 'for sale')
    Category.create(:code => 'bbb', :title => 'services')
    Category.create(:code => 'jjj', :title => 'jobs')
    Category.create(:code => 'ggg', :title => 'gigs')
  end

  def self.down
    drop_table :categories
  end

end
