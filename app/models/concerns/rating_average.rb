module RatingAverage
    extend ActiveSupport::Concern

    def average_rating
      scores = ratings.map { |r| r.score }
      sum = scores.reduce(:+)
      sum/ratings.count
  end
end    