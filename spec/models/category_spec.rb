# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'should have unique name' do
    c1 = FactoryBot.create(:category, name: 'Painting')
    c2 = FactoryBot.build(:category, name: 'Painting')
    expect(c1).to be_valid
    expect(c2).to_not be_valid
  end
  it 'has valid presence of name' do
    expect(FactoryBot.build(:category, name: nil)).to_not be_valid
  end
  it 'should have many artists' do
    t = Category.reflect_on_association(:artists)
    expect(t.macro).to eq(:has_many)
  end
  it 'should delete the artists and associated comments with that artist when category is deleted' do
    category = FactoryBot.create(:category)
    artist = FactoryBot.create(:artist, category:)
    comment = FactoryBot.create(:comment, artist:)
    category.destroy
    expect(Artist.find_by(id: artist.id)).to be_nil
    expect(Comment.find_by(id: comment.id)).to be_nil
  end
  it 'has a valid factory' do
    expect(FactoryBot.build(:category)).to be_valid
  end
end
