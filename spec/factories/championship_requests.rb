FactoryBot.define do
  factory :championship_request do
    campaign
    association :champion, factory: :donor
    relationship { 'Supporter' }
    reason { 'Hello' }
  end
end
