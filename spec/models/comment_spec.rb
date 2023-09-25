# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'has valid presence of body' do
    expect(FactoryBot.build(:comment, body: nil)).to_not be_valid
  end
  it 'has valid presence of rating' do
    expect(FactoryBot.build(:comment, rating: nil)).to_not be_valid
  end
  it 'should belong to artist' do
    t = Comment.reflect_on_association(:artist)
    expect(t.macro).to eq(:belongs_to)
  end
  it 'should have a valid factory' do
    expect(FactoryBot.build(:comment)).to be_valid
  end
  it 'should have default approval as false' do
    cmnt = FactoryBot.build(:comment)
    expect(cmnt.approval).to eq(false)
  end
  it 'should have blank stars as 5 - rating' do
    cmnt = FactoryBot.build(:comment)
    expect(cmnt.blank_stars).to eq(5 - cmnt.rating)
  end
  it 'should belong to user' do
    t = Comment.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
  end
end

RSpec.describe Comment, type: :model do
  context 'should not be valid when' do
    it 'body is nil' do
      expect(FactoryBot.build(:comment, body: nil)).to_not be_valid
    end
    it 'rating is nil' do
      expect(FactoryBot.build(:comment, rating: nil)).to_not be_valid
    end
    it 'rating is not in range of 1 to 5' do
      expect(FactoryBot.build(:comment, rating: 6)).to_not be_valid
    end
    it 'approval is not boolean' do
      expect(FactoryBot.build(:comment, approval: '')).to_not be_valid
    end
    it 'artist_id is nil' do
      expect(FactoryBot.build(:comment, artist_id: nil)).to_not be_valid
    end
    it 'user_id is nil' do
      expect(FactoryBot.build(:comment, user_id: nil)).to_not be_valid
    end
  end
end
