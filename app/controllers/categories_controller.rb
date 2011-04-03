class CategoriesController < ApplicationController

  def index
    @categories = Category.includes(:categories).where(:parent_id => nil)
    category_hashes = @categories.collect {|c| {:code => c.code, :title => c.title, :children => c.categories.collect {|s| {:code => s.code, :title => s.title}}}}
    respond_to do |format|
      format.json { render :json => category_hashes.to_json }
    end
  end

end
