class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.text :name
      t.text :content
      t.integer :total_episodes
      t.boolean :status_movie, default: false
      t.integer :user_id
      t.string :producer_name
      t.string :image_url

      t.timestamps
    end
  end
end
