class Style < ApplicationRecord
  include RatingAverage

  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    name.to_s
  end

  def self.top(amount)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating_in_desc_order[0..(amount - 1)]
  end
end
