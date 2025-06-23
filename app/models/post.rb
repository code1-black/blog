class Post < ApplicationRecord
  has_rich_text :body
  has_many_attached :images
  belongs_to :category, optional: true
  belongs_to :post, optional: true,  dependent: :destroy
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
end
