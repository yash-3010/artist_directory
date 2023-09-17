# frozen_string_literal: true

FactoryBot.define do
  factory :artist do
    name { Faker::Name.name }
    dob { Faker::Date.birthday(min_age: 18, max_age: 65) }
    location { Faker::Address.city }
    work { Faker::Job.title }
    email { Faker::Internet.email }
    links { Faker::Internet.url }
    category { FactoryBot.create(:category) }

    after(:build) do |artist|
      artist.image.attach(io: File.open(Rails.root.join('spec/assets/images/a1.jpg')), filename: 'a1.jpg',
                          content_type: 'image/jpg')
    end
    after(:build) do |artist|
      artist.pictures.attach(io: File.open('spec/assets/images/p1.jpg'), filename: 'p1.jpg',
                             content_type: 'image/jpg')
    end
  end
end
