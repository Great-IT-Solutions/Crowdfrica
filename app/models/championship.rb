class Championship < ApplicationRecord
  belongs_to :campaign
  belongs_to :champion, class_name: 'Donor'
  validates :champion_id, :campaign_id, uniqueness: true
end
