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
  def self.find(id)
    url = "#{ BASE_URL }/songs/" + "#{ id }" #+ "&to=100"
    data = HTTParty.get(url, :headers => { "Authorization" => "Bearer #{ TOKEN }" })

    # Song object: genius_id, song_title, primary_artist, release_date, album, song_description, sample_type
    found_song = Song.new(genius_id: data["response"]["song"]["id"],
      song_title: data["response"]["song"]["title"],
      primary_artist: data["response"]["song"]["primary_artist"]["name"],
      release_date: data["response"]["song"]["release_date"],
      album: data["response"]["song"]["album"]["name"])
    found_song.save

    # iterate over all relationships to create
    # Sample object: genius_id, song_title, primary_artist, ~ song_id,
    found_song_samples = []
    song_relationships_array = data["response"]["song"]["song_relationships"]
    song_relationships_array.each do |obj|
      if obj["type"] == "samples" || obj["type"] == "interpolates"
        obj["songs"].each do |sample|
          wrapper = Sample.new(genius_id: sample["id"], song_title: sample["title"], primary_artist: sample["primary_artist"]["name"], song_id: found_song.genius_id, sample_type: "parent")
          wrapper.save
          found_song_samples << wrapper
        end
      elsif obj["type"] == "sampled_in" || obj["type"] == "interpolated_by"
        obj["songs"].each do |sample|
          wrapper = Sample.new(genius_id: sample["id"], song_title: sample["title"], primary_artist: sample["primary_artist"]["name"], song_id: found_song.genius_id, sample_type: "child")
          wrapper.save
          found_song_samples << wrapper
        end
      elsif obj["type"] == "cover_of"
        obj["songs"].each do |sample|
          wrapper = Sample.new(genius_id: sample["id"], song_title: sample["title"], primary_artist: sample["primary_artist"]["name"], song_id: found_song.genius_id, sample_type: "cover")
          wrapper.save
          found_song_samples << wrapper
        end
      end
    end

    found_song_data = { "song" => found_song, "samples" => found_song_samples }
    return found_song_data
    # return { "song" => found_song }
  end














end
