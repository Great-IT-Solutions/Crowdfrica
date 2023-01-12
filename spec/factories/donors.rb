FactoryBot.define do
  factory :donor do
    sequence(:email) { |n| "test#{n}@crowdfrica.org" }
    password { 'password1234' }
    fullname { 'Tester' }
    registered { true }
  end
end
