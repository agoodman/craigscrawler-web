require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  context "on get index as json" do
    setup { get :index, :format => 'json' }
    should assign_to :categories
    should respond_with :success
  end

end
