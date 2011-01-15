require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many :feeds
  
  should validate_presence_of :first_name
  should validate_presence_of :last_name
  
end