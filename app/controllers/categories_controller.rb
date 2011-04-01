class CategoriesController < ApplicationController

  def index
    @categories = Category.includes(:children).where(:parent_id => nil)
    respond_to do |format|
      format.json { render :json => @categories.to_json(:include => :children, :only => [:code,:title]) }
    end
  end

end
