require 'test_helper'

class QueryTest < ActiveSupport::TestCase

  should have_and_belong_to_many :filters
  should have_and_belong_to_many :keywords
  
  should validate_presence_of :region
  should validate_presence_of :category
  should validate_presence_of :scope

end
