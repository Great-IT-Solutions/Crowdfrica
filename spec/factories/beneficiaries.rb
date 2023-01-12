FactoryBot.define do
  factory :beneficiary do
    beneficiary_name { 'Sarai Whitehead' }
    patient
    trait :patient do
      btype { 'patient' }
    end
    trait :health_facility do
      btype { 'health_facility' }
    end
    trait :classroom_supplies do
      btype { 'classroom_supplies' }
    end
    trait :covid19 do
      btype { 'covid19' }
    end
    country { 'GH' }
  end
end
