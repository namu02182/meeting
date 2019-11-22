class Post < ApplicationRecord
    # dependent 필수
    # has_many :likes, dependent: :destroy
    # has_many :users, through: :likes
    has_one_attached :profile_picture
    has_many :friends, :foreign_key => "owner_id", class_name: 'Post', :dependent => :destroy
    has_many :users, through: :friends, :dependent => :destroy
    has_many :make_friends, :dependent => :destroy
    # dependent 필수
    has_many :comments, :dependent => :destroy
end
