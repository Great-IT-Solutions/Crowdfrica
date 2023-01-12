FactoryBot.define do
  factory :admin_user do
    email { Faker::Internet.email }
    fullname { Faker::Name.name }
    password { 'password1234' }
  end
end
