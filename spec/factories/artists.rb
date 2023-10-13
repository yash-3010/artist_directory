# frozen_string_literal: true

# below is schema for artists table study that
# create_table "artists", force: :cascade do |t|
#   t.string "name", null: false
#   t.date "dob"
#   t.string "location"
#   t.string "work"
#   t.string "email", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.integer "category_id", null: false
#   t.text "links", default: "[]", null: false
#   t.index ["category_id"], name: "index_artists_on_category_id"
#   t.index ["email"], name: "index_artists_on_email", unique: true
# end

FactoryBot.define do
  factory :artist do
    name { Faker::Name.name }
    dob { Faker::Date.birthday(min_age: 18, max_age: 65) }
    location { Faker::Address.city }
    work { Faker::Job.title }
    email { Faker::Internet.email }
    category { FactoryBot.create(:category) }
    links_attributes do
      {
        '0' => {
          'url' => 'https://www.youtube.com/watch?v=lUcfoo51yEk',
          '_destroy' => 'false'
        }
      }
    end

    after(:build) do |artist|
      artist.image.attach(io: File.open(Rails.root.join('spec/fixtures/files/a1.jpg')), filename: 'a1.jpg',
                          content_type: 'image/jpeg')
    end
    after(:build) do |artist|
      artist.pictures.attach(io: File.open('spec/assets/images/p1.jpg'), filename: 'p1.jpg',
                             content_type: 'image/jpeg')
    end
  end
end
