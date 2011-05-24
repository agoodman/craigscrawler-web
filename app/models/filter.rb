class Filter < ActiveRecord::Base

  belongs_to :feed
  has_and_belongs_to_many :feeds
  has_and_belongs_to_many :queries

  validates_presence_of :key, :value
  
end
