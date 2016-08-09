class User < ActiveRecord::Base
  has_many :votes
  has_many :songs, through: :votes


  validates :username,
    presence: true,
    uniqueness: true

  validates :password,
    presence: true,
    length: {minimum: 6}

end
