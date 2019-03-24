class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.text :name
      t.string :episode_url
      t.integer :movie_id
      t.boolean :status_episode, default: false

      t.timestamps
    end
  end
end
