require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  should belong_to :parent
  should have_many :children
  should validate_presence_of :code
  should validate_presence_of :title
  
end
