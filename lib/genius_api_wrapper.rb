require 'httparty'

class GeniusApiWrapper
  BASE_URL = "https://api.genius.com"
  TOKEN = ENV['GENIUS_ACCESS_TOKEN']

  # search function to list results
  def self.list_search_results(query)
    url = "#{ BASE_URL }/search?q=" + "#{ query }" #+ "&to=100"
    data = HTTParty.get(url, :headers => { "Authorization" => "Bearer #{ TOKEN }" })
    search_results_list = []

    if data["response"]["hits"]
      data["response"]["hits"].each do |result|
        target = result["result"]
        wrapper = SearchResult.new(target["full_title"], target["id"], target["title"], target["primary_artist"]["name"])
        search_results_list << wrapper
      end
    end
    return search_results_list
  end

  # find function to return a specific song

end
