class QueriesController < ApplicationController

  def index
    @recent_queries = Query.where(['created_at > ?',Time.now-1.day]).limit(10)
    @top_keywords = Keyword.includes(:queries).all.sort {|x,y| y.queries.count <=> x.queries.count}.first(10)
  end

end
