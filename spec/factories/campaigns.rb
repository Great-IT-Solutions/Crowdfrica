FactoryBot.define do
  factory :campaign do
    campaign_name { 'My big campaign' }
    campaign_headline { 'My big campaign headline' }
    campaign_image_url { 'https://s3.eu-west-2.amazonaws.com/crowdfrica.img/Campaign+imgs/Adults+NHIS/Ama-Baawa-1152-NHIS.jpg' }
    published
    trait :published do
      published { true }
    end
    patient
    trait :patient do
      association :project, :patient
    end
    trait :health_insurance do
      association :project, :health_insurance
    end
    trait :classroom_supplies do
      association :project, :classroom_supplies
    end
    trait :entrepreneur do
      association :project, :entrepreneur
    end
  end

  factory :campaign_unpublished, parent: :campaign do
    published { false }
  end

  factory :campaign_not_yet_funded, parent: :campaign do
    project
  end

  factory :campaign_fully_funded, parent: :campaign do
    association :project, factory: :project_fully_funded
  end
end
