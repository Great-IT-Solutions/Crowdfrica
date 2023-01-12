class ChampionshipRequest < ApplicationRecord
  belongs_to :campaign
  belongs_to :champion, class_name: 'Donor'
end
