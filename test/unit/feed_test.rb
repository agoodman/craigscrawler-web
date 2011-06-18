require 'test_helper'

class FeedTest < ActiveSupport::TestCase

  should belong_to :user
  should have_many :items
  should have_and_belong_to_many :filters
  should have_and_belong_to_many :keywords

  should validate_presence_of :user_id, :region, :category
  
end
