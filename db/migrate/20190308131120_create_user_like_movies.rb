class CreateUserLikeMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :user_like_movies do |t|
      t.integer :user_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
