class SongSerializer < ActiveModel::Serializer
  attributes :id, :genius_id, :song_title, :primary_artist, :release_date, :album

  has_many :samples
end
