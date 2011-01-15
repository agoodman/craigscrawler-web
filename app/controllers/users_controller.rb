class UsersController < Clearance::UsersController
  
  private
  
  def url_after_create
    feeds_path
  end
  
  def url_after_destroy
    root_path
  end
  
end
