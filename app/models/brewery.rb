class Brewery < ApplicationRecord
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   less_than_or_equal_to: ->(_b) { Date.current.year },
                                   only_integer: true }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil,false] }

  def print_report
    puts name
    puts "established #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end

  def self.top(n)
    sorted_by_rating = Brewery.all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating[0..(n-1)]
  end
end
