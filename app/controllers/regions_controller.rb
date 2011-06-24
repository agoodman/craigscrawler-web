class RegionsController < ApplicationController

  def index
    @regions = Region.all
    region_hashes = @regions.collect {|c| {:code => c.code, :title => c.title, :latitude => c.latitude, :longitude => c.longitude, :state => c.state}}
    respond_to do |format|
      format.json { render :json => region_hashes.to_json }
    end
  end

end
