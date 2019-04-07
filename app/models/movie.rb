class Movie < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  has_many :user_movies
  has_many :users, through: :user_movies
end
