class SongSerializer < ActiveModel::Serializer
  attributes :id, :genius_id, :song_title, :primary_artist, :release_date, :album
  has_many :samples

  # class SampleSerializer < ActiveModel::Serializer
  #   attributes :id, :genius_id, :song_title, :primary_artist, :song_id
  #   belongs_to :song
  # end
end
