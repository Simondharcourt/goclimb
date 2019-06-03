class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  # validates :avatar_photo, presence: true
  has_many :reviews
  has_many :routes
  has_many :received_reviews, through: :routes, source: :reviews

  has_many :photos, as: :imageable
  has_many :trips
end
