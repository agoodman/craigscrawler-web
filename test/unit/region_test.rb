require 'test_helper'

class RegionTest < ActiveSupport::TestCase

  should validate_presence_of :code
  should validate_presence_of :title
  
end
