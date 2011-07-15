class Subregion < ActiveRecord::Base
  
  belongs_to :region
  
  validates_presence_of :region_id, :code, :title
  
end
