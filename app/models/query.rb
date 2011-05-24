class Query < ActiveRecord::Base

  has_and_belongs_to_many :filters
  has_and_belongs_to_many :keywords
  
  validates_presence_of :region, :category, :scope
  
end
