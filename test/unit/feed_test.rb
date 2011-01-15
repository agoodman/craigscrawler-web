require 'test_helper'

class FeedTest < ActiveSupport::TestCase

  should belong_to :user
  should have_many :items

  should validate_presence_of :user_id
  
end
