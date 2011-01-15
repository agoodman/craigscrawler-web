class UsersController < Clearance::UsersController
  
  before_filter :authenticate, :only => [ :edit, :show, :update, :destroy ]

  def edit
    @user = current_user
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @user = current_user
    respond_to do |format|
      format.json { render :json => @user }
    end
  end
  
  def update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to account_path, :notice => 'Account Updated' }
        format.json { head :ok }
      else
        format.html { redirect_to account_path, :alert => @user.errors.full_messages.join('<br/>') }
        format.json { render :json => { :errors => @user.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = current_user
    sign_out
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :ok }
    end
  end
  
  private
  
  def url_after_create
    feeds_path
  end
  
  def url_after_destroy
    root_path
  end
  
end
