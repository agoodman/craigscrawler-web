require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  should belong_to :feed
  
  should validate_presence_of :feed_id
  should validate_presence_of :title
  should validate_presence_of :link
  should validate_presence_of :published_at

end
