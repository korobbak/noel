class Movie < ApplicationRecord
  validates :name, presence: true, length: {maximum: 255}
  validates :content, presence: true, length: {maximum: 999}
  validates :total_episodes, presence: true, numericality: {only_integer: true}
  validates :producer_name, presence: true, length: {maximum: 255}
  mount_uploader :image_url, PictureUploader

  belongs_to :user
  has_many :user_like_movies, dependent: :destroy
  has_many :movie_objects, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :episodes, dependent: :destroy
  has_many :movie_types, through: :movie_objects
  accepts_nested_attributes_for :movie_objects

  scope :sort_date, ->{order created_at: :DESC}
  scope :check_status_movie, ->{where "status_movie=false"}
  scope :get_movie_by_year, ->(year, compare){where "extract(year from created_at)#{compare}?", year}
  scope :search_movie_by_name, ->(name){where "name LIKE '#{name}%' or name LIKE '%#{name}%' or name LIKE '%#{name}'"}
end
