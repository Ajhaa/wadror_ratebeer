module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?

    scores = ratings.map(&:score)
    sum = scores.reduce(:+)
    sum / ratings.count.to_f
  end
end
