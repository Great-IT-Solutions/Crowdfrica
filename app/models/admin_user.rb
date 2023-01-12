class AdminUser < ApplicationRecord
  devise :database_authenticatable, :validatable, :lockable, :trackable

  has_many :blog_posts, foreign_key: :author_id, inverse_of: :author, dependent: :destroy
  has_many :comments, as: :commenter, dependent: :destroy
end
