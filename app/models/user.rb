class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  validates :password, length: {minimum: 4},
                       format: /(\S*[A-Z]\S*\d|\S*\d\S*[A-Z])/

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
end
