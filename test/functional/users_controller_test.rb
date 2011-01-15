require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      sign_out
    end
    
    context "on post create" do
      setup { post :create, :user => Factory.attributes_for(:user) }
      should ('redirect to feeds'){redirect_to feeds_path}
    end
    
    context "on get edit" do
      setup { get :edit }
      should ('redirect to sign in'){redirect_to sign_in_path}
    end
    
    context "on put update" do
      setup { put :update, :user => Factory.attributes_for(:user) }
      should ('redirect to sign in'){redirect_to sign_in_path}
    end
    
    context "on delete destroy" do
      setup { delete :destroy }
      should ('redirect to sign in'){redirect_to sign_in_path}
    end
    
    context "on post create as json" do
      setup { post :create, :format => 'json', :user => Factory.attributes_for(:user) }
      should respond_with :success
    end
    
    context "on get show as json" do
      setup { get :show, :format => 'json' }
      should respond_with :unauthorized
    end
    
    context "on put update as json" do
      setup { put :update, :format => 'json', :user => Factory.attributes_for(:user) }
      should respond_with :unauthorized
    end
    
    context "on delete destroy as json" do
      setup { delete :destroy, :format => 'json' }
      should respond_with :unauthorized
    end
  end
  
  context "when signed in" do
    setup do
      @user = Factory(:user)
      sign_in_as @user
    end
    
    context "on get edit" do
      setup { get :edit }
      should respond_with :success
      should assign_to :user
    end
    
    context "on put update" do
      setup { put :update, :user => Factory.attributes_for(:user) }
      should ('redirect to user'){redirect_to account_path}
    end
    
    context "on delete destroy" do
      setup { delete :destroy }
      should ('redirect to root'){redirect_to root_path}
    end
    
    context "on get show as json" do
      setup { get :show, :format => 'json' }
      should respond_with :success
      should assign_to :user
    end
    
    context "on put update as json" do
      setup { put :update, :format => 'json', :user => Factory.attributes_for(:user) }
      should respond_with :success
    end
    
    context "on delete destroy as json" do
      setup { delete :destroy, :format => 'json' }
      should respond_with :success
    end
  end
  
end
