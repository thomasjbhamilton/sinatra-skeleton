class Song < ActiveRecord::Base

  belongs_to :user
  has_many :votes
  has_many :reviews
  has_many :users, through: :votes
  has_many :users, through: :reviews

  validates :song_title,
    presence: true

  validates :author,
    presence: true

  validates :url,
    format: { with: /https?:\/\/.+\..+/ }, if: :url?

end
