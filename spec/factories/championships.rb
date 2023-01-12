FactoryBot.define do
  factory :championship do
    campaign
    association :champion, factory: :donor
    relationship { 'Supporter' }
    message { 'Hello' }
  end
end
