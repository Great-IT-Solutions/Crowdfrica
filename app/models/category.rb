class Category < ApplicationRecord
  extend FriendlyId
  validates :category_name, :category_description, presence: true
  # use friendly_id
  friendly_id :category_name, use: :slugged

  # projects and categories associations
  has_many :projects, dependent: :destroy
end
