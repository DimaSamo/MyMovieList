class Movie < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true
end
