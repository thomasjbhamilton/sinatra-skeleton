class Song < ActiveRecord::Base
  has_many :votes
  has_many :users, through: :votes

  validates :song_title,
    presence: true

  validates :author,
    presence: true

  validates :url,
    format: { with: /https?:\/\/.+\..+/ }, if: :url?

end
