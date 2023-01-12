FactoryBot.define do
  factory :category do
    patient
    trait :patient do
      category_name { 'Patients' }
      initialize_with { Category.find_or_create_by(category_name: category_name) }
      category_description { 'Patients' }
    end
    trait :classroom_supplies do
      category_name { 'Classroom Supplies' }
      initialize_with { Category.find_or_create_by(category_name: category_name) }
      category_description { 'Classroom Supplies' }
    end
    trait :health_insurance do
      category_name { 'Health Insurance' }
      initialize_with { Category.find_or_create_by(category_name: category_name) }
      category_description { 'Health Insurance' }
    end

    trait :entrepreneur do
      category_name { 'Entrepreneur' }
      initialize_with { Category.find_or_create_by(category_name: category_name) }
      category_description { 'Entrepreneur' }
    end

    factory :new_category do
      category_name { 'New Category' }
      initialize_with { Category.find_or_create_by(category_name: category_name) }
      category_description { 'New Category' }
    end
  end
end
