require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  
  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @feed = Factory(:feed, :user => @user)
      sign_out
    end
    
    context "on get index" do
      setup { get :index }
      should ('redirect to sign in'){redirect_to sign_in_path}
    end
    
    context "on post create" do
      setup { post :create, :feed => Factory.attributes_for(:feed, :user => @user) }
      should ('redirect to sign in'){redirect_to sign_in_path}
    end
    
    context "on get show" do
      setup do
        get :show, :id => @feed.id
      end
      should ('redirect to sign in'){redirect_to sign_in_path}
    end
    
    context "on put update" do
      setup do
        put :update, :id => @feed.id, :feed => Factory.attributes_for(:feed)
      end
      should ('redirect to sign in'){redirect_to sign_in_path}
    end
    
    context "on delete destroy" do
      setup do
        delete :destroy, :id => @feed.id
      end
      should ('redirect to sign in'){redirect_to sign_in_path}
    end
    
    context "on get index as json" do
      setup { get :index, :format => 'json' }
      should respond_with :unauthorized
    end
    
    context "on post create as json" do
      setup { post :create, :format => 'json', :feed => Factory.attributes_for(:feed, :user => @user) }
      should respond_with :unauthorized
    end
      
    context "on get show as json" do
      setup { get :show, :format => 'json', :id => @feed.id }
      should respond_with :unauthorized
    end
      
    context "on put update as json" do
      setup { put :update, :format => 'json', :id => @feed.id, :feed => Factory.attributes_for(:feed) }
      should respond_with :unauthorized
    end
      
    context "on delete destroy as json" do
      setup { delete :destroy, :format => 'json', :id => @feed.id }
      should respond_with :unauthorized
    end
  end
    
  context "when signed in" do
    setup do
      @user = Factory(:user)
      @feed = Factory(:feed, :user => @user)
      sign_in_as @user
    end
    
    context "on get index" do
      setup { get :index }
      should respond_with :success
      should assign_to :feeds
      should render_template :index
    end
    
    context "on post create" do
      setup { post :create, :feed => Factory.attributes_for(:feed, :user => @user) }
      should ('redirect to feed'){redirect_to feed_path(assigns(:feed))}
    end
    
    context "on get show" do
      setup do
        get :show, :id => @feed.id
      end
      should respond_with :success
      should assign_to :feed
      should render_template :show
    end
    
    context "on put update" do
      setup do
        put :update, :id => @feed.id, :feed => Factory.attributes_for(:feed)
      end
      should ('redirect to feed'){redirect_to @feed}
    end
    
    context "on delete destroy" do
      setup do
        delete :destroy, :id => @feed.id
      end
      should ('redirect to feeds'){redirect_to feeds_path}
    end
    
    context "on get index as json" do
      setup { get :index, :format => 'json' }
      should respond_with :success
      should assign_to :feeds
    end
    
    context "on post create as json" do
      setup { post :create, :format => 'json', :feed => Factory.attributes_for(:feed, :user => @user) }
      should respond_with :success
      should assign_to :feed
    end
      
    context "on get show as json" do
      setup { get :show, :format => 'json', :id => @feed.id }
      should respond_with :success
      should assign_to :feed
    end
      
    context "on put update as json" do
      setup { put :update, :format => 'json', :id => @feed.id, :feed => Factory.attributes_for(:feed) }
      should respond_with :success
    end
      
    context "on delete destroy as json" do
      setup { delete :destroy, :format => 'json', :id => @feed.id }
      should respond_with :success
    end
  end
    
end
