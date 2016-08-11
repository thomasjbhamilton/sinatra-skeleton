class AddReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :song_id
      t.integer :user_id
      t.string :comment
    end
  end
end
