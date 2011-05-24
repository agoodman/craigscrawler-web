require 'test_helper'

class FilterTest < ActiveSupport::TestCase

  should have_and_belong_to_many :feeds
  should have_and_belong_to_many :queries
  
  should validate_presence_of :key
  should validate_presence_of :value
  
end
