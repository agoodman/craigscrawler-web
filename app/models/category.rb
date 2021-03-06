class Category < ActiveRecord::Base

  belongs_to :parent, :class_name => 'Category'
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'
  
  validates_presence_of :code, :title
  
  def title
    attributes['title'].titleize unless attributes['title'].nil?
  end
  
end
