class Project < ApplicationRecord
  extend FriendlyId

  has_rich_text :project_description

  # Use friendly_id for id
  friendly_id :project_name, use: :slugged

  validates :project_name, presence: true

  belongs_to :category
  belongs_to :beneficiary
  has_one :campaign, dependent: :destroy
  has_many :donations, dependent: :destroy
  has_many :donors, through: :donations
  has_many :comments, as: :commentable, dependent: :destroy
end
