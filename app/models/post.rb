class Post < ApplicationRecord
    # dependent 필수
    # has_many :likes, dependent: :destroy
    # has_many :users, through: :likes
    has_one_attached :profile_picture
    has_many :friends, :dependent => :destroy
    has_many :users, through: :friends, :dependent => :destroy
    # dependent 필수
    has_many :comments, dependent: :destroy
end
