require 'net/http'

class EmailsController < ApplicationController

  def index
    logger = Logger.new(STDOUT)
    uri = URI.parse(params[:item][:link])
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri, { 'User-Agent' => 'Mozilla/5.0 (Linux) Gecko/20101203 Firefox/3.6.13' })
    response = http.request(request)
    
    doc = Nokogiri::HTML(response.body)
    
    link_matches = doc.css("a")
    logger.debug("#{link_matches.count} found")
    link_matches.each {|match| logger.debug(match)}
    matches = link_matches.select {|match| match.attributes['href'].value =~ /mailto\:/}
    logger.debug("#{matches.count} containing mailto")
    matches.each {|match| logger.debug(match)}
    emails = matches.collect {|match| match.text}.uniq
    respond_to do |format|
      format.json { render :json => emails }
    end
  end
  
end
