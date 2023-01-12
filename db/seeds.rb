# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
PaypalPaymentLog.destroy_all
Donor.destroy_all
Project.destroy_all
Campaign.destroy_all
Beneficiary.destroy_all
Category.destroy_all
Donation.destroy_all
AdminUser.destroy_all
BlogPost.destroy_all

# Create Donors
patient_imgs = ['https://s3-eu-west-1.amazonaws.com/crowdfrica/images/adults/Mary_Essel-8027.jpg',
                'https://s3-eu-west-1.amazonaws.com/crowdfrica/images/child/crowdfrica_James_Essiandow-7865.jpg',
                'https://s3.eu-west-2.amazonaws.com/crowdfrica.img/Campaign+imgs/Children+NHIS/Sarah_Abekah-8177.jpg']
donor_imgs = ['https://s3.eu-west-2.amazonaws.com/crowdfrica.img/Campaign+imgs/Adults+NHIS/Yaa%2BKitsiwa-8076.jpg',
              'https://s3.eu-west-2.amazonaws.com/crowdfrica.img/Campaign+imgs/Patients/SAB.jpeg',
              'https://s3.eu-west-2.amazonaws.com/crowdfrica.img/Campaign+imgs/Adults+NHIS/Ama-Baawa-1152-NHIS.jpg']
49.times do
  Donor.create(
    fullname: Faker::Name.name,
    email: Faker::Internet.unique.email,
    gender: Faker::Gender.binary_type.downcase!,
    country: Faker::Address.country,
    registered: true,
    image: donor_imgs[rand(3)],
    password: '123456'
  )
end
# Create another donor
Donor.create(
  fullname: 'John Smith',
  email: 'jsmith@gmail.com',
  gender: 'male',
  country: 'France',
  registered: true,
  image: donor_imgs[rand(3)],
  password: 'password'
)

AdminUser.create(
  fullname: 'Admin User',
  email: 'jsmith@gmail.com',
  password: 'password'
)

# Create the three categories
categories = ['Patients', 'Health Insurance', 'Classroom Supplies']
categories.each do |category|
  Category.create(
    category_name: category,
    category_description: 'For those in need of help with ' + category + '.'
  )
end
# Create the Entrepreneur category
Category.create(
  category_name: 'Entrepreneurs',
  category_description: 'Entrepreneurs',
  slug: 'covid19-efforts'
)

40.times do
  Beneficiary.create(
    beneficiary_name: Faker::Name.name,
    country: Faker::Address.country,
    btype: 'patient'
  )
end
# Creat Projects for medical issues
beneficiaries_patient = Beneficiary.first(20)
medical = rand(1500)
processing = rand(50)
operational = rand(4)
beneficiaries_patient.each do |beneficiary|
  Project.create(
    project_name: Faker::Lorem.sentence,
    project_description: Faker::Lorem.paragraph,
    expires_at: Date.today + 5.years,
    beneficiary_id: beneficiary.id,
    category_id: Category.find_by(category_name: 'Patients').id,
    ailment_or_equipment: Faker::Cosmere.aon + 'itus',
    medical_cost: medical,
    processing: processing,
    operational_costs: operational,
    cost: processing + medical + operational
  )
end
# creat projects for health insurance
beneficiaries_insurance = Beneficiary.last(20)
beneficiaries_insurance.each do |beneficiary|
  Project.create(
    project_name: Faker::Lorem.sentence,
    project_description: Faker::Lorem.paragraph,
    expires_at: Date.today + 5.years,
    beneficiary_id: beneficiary.id,
    ailment_or_equipment: Faker::Cosmere.aon + 'itus',
    category_id: Category.find_by(category_name: 'Health Insurance').id,
    year_cost: 5,
    renewal: 0,
    processing: 1,
    operational_costs: 4,
    cost: 10
  )
end

# Create all the index_campaigns

projects = Project.all

projects.each do |project|
  Campaign.create(
    campaign_headline: project.beneficiary.beneficiary_name + ' is in great need please help them in anyway you can',
    campaign_image_url: patient_imgs[rand(3)],
    project_id: project.id,
    campaign_name: project.beneficiary.beneficiary_name + ' needs your help help!',
    published: true
  )
end
150.times do
  Donation.create!(
    amount: rand(1..26),
    donor_id: Donor.pluck(:id).sample(1)[0],
    project_id: Project.pluck(:id).sample(1)[0],
    anonymous: false
  )
end

# create blog_posts
15.times do |time|
  post = BlogPost.new(
    title: Faker::Book.unique.title + time.to_s,
    summary: Faker::Lorem.paragraph(sentence_count: 3),
    body: Faker::Lorem.paragraph(sentence_count: 50),
    author_id: AdminUser.first.id,
    tags: %w[health education],
    image_url: patient_imgs[rand(3)]
  )
  post.save!
end
