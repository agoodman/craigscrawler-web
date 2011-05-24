require 'test_helper'

class QueriesControllerTest < ActionController::TestCase

  context "on get index" do
    setup { get :index }
    
    should respond_with :success
    should assign_to :recent_queries
    should assign_to :top_keywords
  end

end
