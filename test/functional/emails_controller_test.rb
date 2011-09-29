require 'test_helper'

class EmailsControllerTest < ActionController::TestCase

  context "on get index as json" do
    setup { get :index, :format => 'json' }
    should respond_with :success
  end
  
end
