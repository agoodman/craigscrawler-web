class Keyword < ActiveRecord::Base

  belongs_to :feed
  
  validates_presence_of :feed_id, :value
  
end
