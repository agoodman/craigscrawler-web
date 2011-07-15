class Region < ActiveRecord::Base

  has_many :subregions
  
  validates_presence_of :code, :title
  
  def title
    attributes['title'].titleize unless attributes['title'].nil?
  end

end
