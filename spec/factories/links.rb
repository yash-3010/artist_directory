# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    url { 'https://www.youtube.com/watch?v=lUcfoo51yEk' }
    artist
  end
end
