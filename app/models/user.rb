class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
         
  # dependent 필수
  # has_many :likes, dependent: :destroy
  # has_many :posts, through: :likes
  has_many :friends, dependent: :destroy
  has_many :posts, through: :friends, dependent: :destroy
end

