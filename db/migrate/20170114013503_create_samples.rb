class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.integer :genius_id
      t.string :song_title
      t.string :primary_artist
      t.belongs_to :song, index: true

      t.timestamps null: false
    end
  end
end
