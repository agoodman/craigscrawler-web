require 'test_helper'

class FilterTest < ActiveSupport::TestCase

  should belong_to :feed
  
  should validate_presence_of :key
  should validate_presence_of :value
  
end
