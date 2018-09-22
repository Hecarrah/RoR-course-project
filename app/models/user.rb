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
end
