module RatingAverage
    extend ActiveSupport::Concern

    def average_rating
        arr = self.ratings.map{ |r|r.score}
        (arr.reduce(:+).to_f / arr.size).round(2)
    end
end