class Feed < ActiveRecord::Base

  belongs_to :user
  has_many :items, :dependent => :destroy
  has_many :keywords, :dependent => :destroy
  
  validates_presence_of :user_id

  REGIONS = { 'tampa' => 'Tampa' }
  CATEGORIES = { 'mca' => 'Motorcycles' }
  
end
