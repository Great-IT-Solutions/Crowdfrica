class BlogPost < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_rich_text :body

  validates :title, :summary, :body, presence: true
  validates :title, uniqueness: { case_sensitive: false }
  validates :image_url, presence: true

  belongs_to :author, class_name: 'AdminUser'
  has_many :comments, as: :commentable, dependent: :destroy

  scope :with_tag, ->(tag) { tag.nil? ? by_created_at : where(':tag = ANY (tags)', tag: tag).by_created_at }
  scope :by_created_at, -> { order(created_at: :desc) }
end
