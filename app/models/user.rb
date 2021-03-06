class User < ApplicationRecord
  belongs_to :user_role
  has_many :movies, dependent: :destroy
  has_many :user_like_movies, dependent: :destroy
  has_many :comments, dependent: :destroy

  attr_reader :remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :last_name, presence: true, length: {maximum: 255}
  validates :first_name, presence: true, length: {maximum: 255}
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    @remember_token = User.new_token
    update remember_digest: User.digest(@remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest.present?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update remember_digest: nil
  end
end
