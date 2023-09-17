# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist, type: :model do
  it 'has valid presence of name' do
    expect(FactoryBot.build(:artist, name: nil)).to_not be_valid
  end
  it 'has valid presence of email' do
    expect(FactoryBot.build(:artist, email: nil)).to_not be_valid
  end
  it 'has valid presence of category_id' do
    expect(FactoryBot.build(:artist, category_id: nil)).to_not be_valid
  end
  it 'should have many comments' do
    t = Artist.reflect_on_association(:comments)
    expect(t.macro).to eq(:has_many)
  end
  it 'should have dependent destroy on comment' do
    t = Artist.reflect_on_association(:comments)
    expect(t.options[:dependent]).to eq(:destroy)
  end
  it 'should belong to category' do
    t = Artist.reflect_on_association(:category)
    expect(t.macro).to eq(:belongs_to)
  end
  it 'should have one attached image' do
    expect(FactoryBot.build(:artist).image).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end

RSpec.describe Artist, type: :model do
  it 'should have many attached pictures' do
    expect(FactoryBot.build(:artist).pictures).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
  it 'should have pictures of type image/jpeg' do
    expect(FactoryBot.build(:artist).pictures.first.content_type).to eq('image/jpeg')
  end
  it 'has a valid factory' do
    expect(FactoryBot.build(:artist)).to be_valid
  end
  it 'should destroy active storage attachments on destroy' do
    artist = FactoryBot.create(:artist)
    artist.destroy
    expect(ActiveStorage::Attachment.count).to eq(0)
  end
  it 'should destroy all the comments related to artist on destroy' do
    artist = FactoryBot.create(:artist)
    FactoryBot.create(:comment, artist_id: artist.id)
    artist.destroy
    expect(Comment.where(artist_id: artist.id).count).to eq(0)
  end
  it 'should have image of type image/jpeg' do
    expect(FactoryBot.build(:artist).image.content_type).to eq('image/jpeg')
  end
end
