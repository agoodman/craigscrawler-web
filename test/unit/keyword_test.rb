require 'test_helper'

class KeywordTest < ActiveSupport::TestCase

  should belong_to :feed
  should validate_presence_of :feed_id
  should validate_presence_of :value

end
