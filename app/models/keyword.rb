class Keyword < ActiveRecord::Base

  has_and_belongs_to_many :feeds
  has_and_belongs_to_many :queries
  
  validates_presence_of :value
  
end
