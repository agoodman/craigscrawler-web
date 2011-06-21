require 'test_helper'

class Feeds::ItemsControllerTest < ActionController::TestCase

  context "with a user and a feed and an item" do
    setup do
      @user = Factory(:user)
      @feed = Factory(:feed, :user => @user)
      @item = Factory(:item, :feed => @feed)
    end
    
    context "when not signed in" do
      setup do
        sign_out
      end
      
      context "on get index as json" do
        setup do
          get :index, :feed_id => @feed.id, :format => 'json'
        end
      
        should respond_with :unauthorized
      end
      
      context "on get show as json" do
        setup do
          get :show, :feed_id => @feed.id, :id => @item.id, :format => 'json'
        end
        
        should respond_with :unauthorized
      end
    end
  
    context "when signed in" do
      setup do
        sign_in_as @user
      end
      
      context "on get index as json" do
        setup do
          get :index, :feed_id => @feed.id, :format => 'json'
        end
        
        should respond_with :success
        should assign_to :items
        should ("include only user's items"){assert_same_elements(assigns(:items),[@item])}
      end

      context "on get show as json" do
        setup do
          get :show, :feed_id => @feed.id, :id => @item.id, :format => 'json'
        end
        
        should respond_with :success
        should assign_to :item
      end
    end
  end
  
end
