class Region < ActiveRecord::Base

  validates_presence_of :code, :title
  
  def title
    attributes['title'].titleize
  end

end
