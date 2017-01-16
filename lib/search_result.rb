class SearchResult
  attr_reader :full_title, :id, :title, :primary_artist

  def initialize(full_title, id, title, primary_artist)
    @full_title = full_title
    @id = id
    @title = title
    @primary_artist = primary_artist
  end

  def self.all(query)
    results = GeniusApiWrapper.list_search_results(query)
    return results
  end

end
