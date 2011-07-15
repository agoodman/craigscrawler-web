class SubregionsController < ApplicationController

  def index
    @regions = Region.includes(:subregions).all
    hash = Hash[@regions.select {|r| !r.subregions.empty?}.map {|r| [r.code,r.subregions.collect {|s| {:code=>s.code,:title=>s.title.titleize}}]}]
    respond_to do |format|
      format.json { render :json => hash.to_json }
    end
  end

end
