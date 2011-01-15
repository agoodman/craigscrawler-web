class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  
  private
  
  def deny_access
    respond_to do |format|
      format.html {
        flash[:alert] = 'You must be signed in.'
        redirect_to sign_in_path
      }
      format.json { render :json => 'You are not signed in.', :status => :unauthorized }
    end
  end
  
end
