class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :release_year
      t.string :plot
      t.decimal :rating
      t.string :image_url
      t.timestamps null: false
    end
  end
end
