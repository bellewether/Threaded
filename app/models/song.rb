class Song < ActiveRecord::Base
  has_many :samples

  validates :genius_id, presence: true
end
