module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    arr = ratings.map(&:score)
    (arr.reduce(:+).to_f / arr.size).round(2)
  end
end
