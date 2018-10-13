class Style < ApplicationRecord
  include RatingAverage
  has_many :beers
  has_many :ratings, through: :beers
  def to_s
    name
  end

  def self.top(n)
    sorted_by_rating = Style.all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating[0..(n-1)]
  end
end
