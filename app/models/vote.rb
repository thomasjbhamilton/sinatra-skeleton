class Vote < ActiveRecord::Base

  belongs_to :song
  belongs_to :user

  validates :song_id, uniqueness: { scope: :user_id,
    message: "You can only upvote a song once!" }

end
