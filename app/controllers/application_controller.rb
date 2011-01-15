class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  
  private
  
  def deny_access
    flash[:alert] = 'You must be signed in.'
    redirect_to sign_in_path
  end
  
end
