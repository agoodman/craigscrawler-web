require 'test_helper'

class Feeds::KeywordsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @feed = Factory(:feed, :user => @user)
      sign_out
    end
    
    context "on post create" do
      setup { post :create, :feed_id => @feed.id, :keyword => Factory.attributes_for(:keyword) }
      should ('redirect to sign in'){redirect_to sign_in_path}
    end
    
    context "on delete destroy" do
      setup do
        @keyword = Factory(:keyword)
        @feed.keywords << @keyword unless @feed.keywords.include?(@keyword)
        delete :destroy, :feed_id => @feed.id, :id => @keyword.id
      end
      should ('redirect to sign in'){redirect_to sign_in_path}
    end
    
    context "on post create as json" do
      setup { post :create, :format => 'json', :feed_id => @feed.id, :keyword => Factory.attributes_for(:keyword) }
      should respond_with :unauthorized
    end
    
    context "on delete destroy as json" do
      setup do
        @keyword = Factory(:keyword)
        @feed.keywords << @keyword unless @feed.keywords.include?(@keyword)
        delete :destroy, :format => 'json', :feed_id => @feed.id, :id => @keyword.id
      end
      should respond_with :unauthorized
    end
  end
  
  context "when signed in" do
    setup do
      @user = Factory(:user)
      @feed = Factory(:feed, :user => @user)
      sign_in_as @user
    end
    
    context "on post create" do
      setup { post :create, :feed_id => @feed.id, :keyword => Factory.attributes_for(:keyword) }
      should ('redirect to feed'){redirect_to feed_path(@feed)}
    end
    
    context "on delete destroy" do
      setup do
        @keyword = Factory(:keyword)
        @feed.keywords << @keyword unless @feed.keywords.include?(@keyword)
        delete :destroy, :feed_id => @feed.id, :id => @keyword.id
      end
      should ('redirect to feed'){redirect_to feed_path(@feed)}
    end

    context "on post create as json" do
      setup { post :create, :format => 'json', :feed_id => @feed.id, :keyword => Factory.attributes_for(:keyword) }
      should respond_with :success
    end
    
    context "on delete destroy as json" do
      setup do
        @keyword = Factory(:keyword)
        @feed.keywords << @keyword unless @feed.keywords.include?(@keyword)
        delete :destroy, :format => 'json', :feed_id => @feed.id, :id => @keyword.id
      end
      should respond_with :success
    end
  end
  
end
