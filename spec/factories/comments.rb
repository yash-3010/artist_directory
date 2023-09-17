# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }
    artist { FactoryBot.create(:artist) }
    user { FactoryBot.create(:user) }
    rating { Faker::Number.between(from: 1, to: 5) }
    approval { false }
  end
end
