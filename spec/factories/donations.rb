FactoryBot.define do
  factory :donation do
    donor
    project
    amount { 25 }
    order_status { 'Successful' }
    sequence(:order_id) { |n| n }
  end

  factory :emergent_donation, parent: :donation do
    via { 'emergent' }
  end

  factory :stripe_donation, parent: :donation do
    via { 'stripe' }
  end

  factory :mpower_donation, parent: :donation do
    via { 'mpower' }
  end

  factory :interpay_donation, parent: :donation do
    via { 'interpay' }
  end

  factory :rave_donation, parent: :donation do
    via { 'rave payment' }
  end

  factory :paypal_donation, parent: :donation do
    via { 'paypal' }
    after(:create) do |donation|
      create(:paypal_payment_log, donation: donation)
    end
  end

  factory :squareup_donation, parent: :donation do
    via { 'squareup payment' }
  end
end
