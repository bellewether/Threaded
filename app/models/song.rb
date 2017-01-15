class Song < ActiveRecord::Base
  has_many :samples

  validates :genius_id, presence: true

  def self.find(id)
    result = GeniusApiWrapper.find(id)
    return result
  end

end
