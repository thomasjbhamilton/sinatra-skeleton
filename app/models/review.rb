class Review < ActiveRecord::Base

  belongs_to :song
  belongs_to :user

  validates :song_id, uniqueness: { scope: :user_id,
    message: "You can Reveiw a song once!" },
    presence: true

  validates :user_id, presence: true

end
