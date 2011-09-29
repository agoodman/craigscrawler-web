require 'test_helper'

class SubregionsControllerTest < ActionController::TestCase

  context "on get index as json" do
    setup { get :index, :format => 'json' }
    should assign_to :regions
    should respond_with :success
  end

end
