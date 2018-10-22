module TopN
  extend ActiveSupport::Concern

  def top(number)
    sorted_by_rating = all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating[0..(number - 1)]
  end
end
