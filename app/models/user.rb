class User < ApplicationRecord
  include RatingAverage
  extend TopN
  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  validates :password, length: { minimum: 4 },
                       format: /(\S*[A-Z]\S*\d|\S*\d\S*[A-Z])/

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favourite_beer
    return nil if ratings.empty?

    ratings.max_by(&:score).beer
  end

  def favourite_style
    return nil if ratings.empty?

    beers.first.style
  end

  def style_ratings
    ratings.map { |r| { style: r.beer.style, score: r.score } }
  end

  def name
    username
  end
end
