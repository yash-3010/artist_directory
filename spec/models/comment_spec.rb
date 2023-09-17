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
end
