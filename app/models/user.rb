class User < ActiveRecord::Base
  has_secure_password
  validates :user_name, presence: true, uniqueness: true
  validates :email, presence:true, uniqueness: true
  validates :password, presence:true
  has_many :user_movies
  has_many :movies, through: :user_movies
end
