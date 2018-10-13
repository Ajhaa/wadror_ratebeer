class Beer < ApplicationRecord
  include RatingAverage
  belongs_to :style
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

  def to_s
    "#{name} by #{brewery.name}"
  end

  def self.top(n)
    sorted_by_rating = Beer.all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating[0..(n-1)]
  end
end
