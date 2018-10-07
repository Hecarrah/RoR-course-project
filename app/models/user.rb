class User < ApplicationRecord
  include RatingAverage
  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true
  validates :username, length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }
  validates :password, format: { with: /.*[A-Z]+.*/, message: "Must contain an uppercase letter." }
  validates :password, format: { with: /.*[0-9]+.*/, message: "Must contain a number." }

  def favorite_beer
    return nil if ratings.empty?

    ratings.max_by(&:score).beer
  end

  def favorite_style
    return nil if ratings.empty?

    sums = Hash.new(0)
    beers.select("style_id").distinct.map(&:style_id).each do |style|
      stylearr = ratings.joins("left join beers on beers.id = beer_id").where("beers.style_id = '#{style}'").map(&:score)
      stylesum = (stylearr.reduce(0, :+) / stylearr.size)
      sums[style] = stylesum.to_i
    end
    Style.find(sums.key(sums.values.max)).name
  end

  def favorite_brewery
    return nil if ratings.empty?

    sums = Hash.new(0)
    beers.map(&:brewery_id).uniq.each do |id|
      namearr = ratings.joins("left join beers on beers.id = beer_id").where("beers.brewery_id = '#{id}'").map(&:score)
      namesum = namearr.reduce(0, :+) / namearr.size
      sums[id] = namesum.to_i
    end
    Brewery.find(sums.key(sums.values.max)).name
  end
end
