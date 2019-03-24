class Episode < ApplicationRecord
  belongs_to :movie
  scope :sort_date, ->{order created_at: :DESC}
end
