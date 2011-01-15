class Feed < ActiveRecord::Base

  belongs_to :user
  has_many :items, :dependent => :destroy, :order => 'published_at desc'
  has_many :keywords, :dependent => :destroy
  
  validates_presence_of :user_id

  REGIONS = { 'tampa' => 'Tampa' }
  CATEGORIES = { 'mca' => 'Motorcycles' }

  def last_item_published_at
    if items.empty?
      Date.new(2000)
    else
      items.first.published_at unless items.empty?
    end
  end
  
end
