require 'net/http'

class ImagesController < ApplicationController

  def index
    uri = URI.parse(params[:item][:link])
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri, { 'User-Agent' => 'Mozilla/5.0 (Linux) Gecko/20101203 Firefox/3.6.13' })
    response = http.request(request)
    
    doc = Nokogiri::HTML(response.body)
    
    matches = doc.css("#userbody table td img")
    image_urls = matches.collect {|match| match.attributes['src'].value}
    respond_to do |format|
      format.json { render :json => image_urls }
    end
  end
  
end
