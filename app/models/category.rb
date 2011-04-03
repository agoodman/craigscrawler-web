class Category < ActiveRecord::Base

  belongs_to :parent, :class_name => 'Category'
  has_many :categories, :foreign_key => 'parent_id'
  
  validates_presence_of :code, :title
  
  def title
    attributes['title'].titleize
  end
  
end
