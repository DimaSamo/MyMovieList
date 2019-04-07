class AddColumnsToUserMovies < ActiveRecord::Migration
  def change
    add_column :user_movies, :seen, :boolean
    add_column :user_movies, :personal_rating, :decimal
    add_column :user_movies, :comment, :string
  end
end
