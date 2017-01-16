class SongsController < ApplicationController

  def index
    query = params[:q]
    results = SearchResult.all(query)
    render json: { "results": results }

  end

  def show
    id = params[:id]
    result = Song.find(id)
    render json: result
  end

end
