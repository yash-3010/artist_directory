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
end

RSpec.describe Artist, type: :model do
  it 'should destroy all the comments related to artist on destroy' do
    artist = FactoryBot.create(:artist)
    FactoryBot.create(:comment, artist_id: artist.id)
    artist.destroy
    expect(Comment.where(artist_id: artist.id).count).to eq(0)
  end
  it 'should have image of type image/jpeg' do
    expect(FactoryBot.build(:artist).image.content_type).to eq('image/jpeg')
  end
  it 'should have unique email for each artist' do
    artist1 = FactoryBot.create(:artist, email: 'mail@valid.com')
    artist2 = FactoryBot.build(:artist, email: 'mail@valid.com')
    expect(artist1).to be_valid
    expect(artist2).to_not be_valid
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
end

RSpec.describe Artist, type: :model do
  it 'should destroy all the comments related to artist on destroy' do
    artist = FactoryBot.create(:artist)
    FactoryBot.create(:comment, artist_id: artist.id)
    artist.destroy
    expect(Comment.where(artist_id: artist.id).count).to eq(0)
  end
  it 'should have image of type image/jpeg' do
    expect(FactoryBot.build(:artist).image.content_type).to eq('image/jpeg')
  end
  it 'should have unique email for each artist' do
    artist1 = FactoryBot.create(:artist, email: 'mail@valid.com')
    artist2 = FactoryBot.build(:artist, email: 'mail@valid.com')
    expect(artist1).to be_valid
    expect(artist2).to_not be_valid
  end
end

RSpec.describe Artist, type: :model do
  context 'should not be valid when' do
    it 'name is nil' do
      expect(FactoryBot.build(:artist, name: nil)).to_not be_valid
    end
    it 'name is empty' do
      expect(FactoryBot.build(:artist, name: '')).to_not be_valid
    end
    it 'email is nil' do
      expect(FactoryBot.build(:artist, email: nil)).to_not be_valid
    end
    it 'email is empty' do
      expect(FactoryBot.build(:artist, email: '')).to_not be_valid
    end
    it 'email is not unique' do
      FactoryBot.create(:artist, email: 'mail@valid.com')
      expect(FactoryBot.build(:artist, email: 'mail@valid.com')).to_not be_valid
    end
  end
end
RSpec.describe Artist, type: :model do
  context 'should not be valid when' do
    it 'category_id is nil' do
      expect(FactoryBot.build(:artist, category_id: nil)).to_not be_valid
    end
    it 'category_id is empty' do
      expect(FactoryBot.build(:artist, category_id: '')).to_not be_valid
    end
    it 'category_id is not a number' do
      expect(FactoryBot.build(:artist, category_id: 'string')).to_not be_valid
    end
    it 'category_id is not a valid category id' do
      expect(FactoryBot.build(:artist, category_id: 100)).to_not be_valid
    end
  end
end
