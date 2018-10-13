module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?

    arr = ratings.map(&:score)
    (arr.reduce(:+).to_f / arr.size)
  end
end
