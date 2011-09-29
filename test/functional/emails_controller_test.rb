require 'test_helper'

class EmailsControllerTest < ActionController::TestCase

  context "on get index as json" do
    setup { get :index, :format => 'json', :item => { :link => "http://tampa.craigslist.org/hil/bab/2623847785.html" } }
    should respond_with :success
  end
  
end
