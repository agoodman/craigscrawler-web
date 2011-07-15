require 'test_helper'

class SubregionTest < ActiveSupport::TestCase

  should belong_to :region
  
  should validate_presence_of :region_id
  should validate_presence_of :code
  should validate_presence_of :title

end
