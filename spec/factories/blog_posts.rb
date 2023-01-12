require 'faker'
FactoryBot.define do
  factory :blog_post do
    body { '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>' }
    title { Faker::Book.unique.title }
    summary { 'A summary description of this blog post' }
    image_url { 'https://s3.eu-west-2.amazonaws.com/crowdfrica.img/Campaign+imgs/Adults+NHIS/Ama-Baawa-1152-NHIS.jpg' }
    author_bio { Faker::Lorem.sentence }
    association :author, factory: :admin_user
  end
end
