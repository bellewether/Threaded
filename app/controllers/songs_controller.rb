class SongsController < ApplicationController

  def index
    query = params[:q]
    results = SearchResult.all(query)
    render json: { "hits": results }

  end

  def show

  end

end
