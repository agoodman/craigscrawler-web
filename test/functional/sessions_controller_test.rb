require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      sign_out
    end
    
    context "on get new" do
      setup { get :new }
      should respond_with :success
      should render_template :new
    end
    
    context "on post create" do
      setup { post :create, :session => { :email => @user.email, :password => @user.password } }
      should ('redirect to feeds'){redirect_to feeds_path}
    end
    
    context "on post create as json" do
      setup { post :create, :format => 'json', :session => { :email => @user.email, :password => @user.password } }
      should respond_with :success
    end
  end
  
  context "when signed in" do
    setup do
      @user = Factory(:user)
      sign_in_as @user
    end
    
    context "on get destroy" do
      setup { get :destroy }
      should ('redirect to root'){redirect_to root_path}
    end
    
    context  "on delete destroy" do
      setup { delete :destroy }
      should ('redirect to root'){redirect_to root_path}
    end
    
    context "on delete destroy as json" do
      setup { delete :destroy, :format => 'json' }
      should respond_with :success
    end
  end
  
end
