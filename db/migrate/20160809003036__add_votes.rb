class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :song_id
      t.integer :user_id
    end
  end
end
