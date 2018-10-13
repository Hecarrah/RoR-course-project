class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1040, less_than_or_equal_to: lambda { |l| Time.now.year if l.year }, only_integer: true }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil,false] }

  def print_report
    puts name
    puts "Enstablished at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2018
    puts "changed enstablishment year to #{year}"
  end

  def to_s
    name.to_s
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating_in_desc_order[0..n-1]
  end
end
