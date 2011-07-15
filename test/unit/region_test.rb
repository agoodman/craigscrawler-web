require 'test_helper'

class RegionTest < ActiveSupport::TestCase

  should have_many :subregions
  
  should validate_presence_of :code
  should validate_presence_of :title
  
end
