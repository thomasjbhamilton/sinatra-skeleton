class AddSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :song_title
      t.string :author
      t.string :url
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :user_id
    end
  end
end
