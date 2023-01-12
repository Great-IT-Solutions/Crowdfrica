FactoryBot.define do
  factory :project do
    project_name { 'Big project' }
    project_description { '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>' }
    cost { 150 }
    trait :patient do
      association :category, :patient
      association :beneficiary, :patient
    end
    trait :health_insurance do
      association :category, :health_insurance
      association :beneficiary, :patient
    end
    trait :classroom_supplies do
      association :category, :classroom_supplies
      association :beneficiary, :classroom_supplies
    end

    trait :entrepreneur do
      association :category, :entrepreneur
      association :beneficiary, :entrepreneur
    end

    patient
  end

  factory :project_fully_funded, parent: :project do
    cost { 0 }
  end
end
