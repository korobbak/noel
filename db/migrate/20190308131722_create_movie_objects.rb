class CreateMovieObjects < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_objects do |t|
      t.integer :movie_type_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
