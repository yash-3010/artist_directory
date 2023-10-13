# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'King@1234' }
    password_confirmation { 'King@1234' }
  end
end
