class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :genius_id
      t.string :song_title
      t.string :primary_artist
      t.string :release_date
      t.string :album
      t.string :song_description
      t.string :sample_type # parent, alpha, or child

      t.timestamps null: false
    end
  end
end
