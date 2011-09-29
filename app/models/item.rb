class Item < ActiveRecord::Base

  belongs_to :feed
  
  validates_presence_of :feed_id, :title, :link, :published_at
  
  scope :stale, where(['created_at < ?',Time.now-30.days])
  
end
