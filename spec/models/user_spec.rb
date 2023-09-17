# frozen_string_literal: true

require 'rails_helper'

# Devise model called User

RSpec.describe User, type: :model do
  it 'has valid presence of email' do
    expect(FactoryBot.build(:user, email: nil)).to_not be_valid
  end
  it 'has valid presence of password' do
    expect(FactoryBot.build(:user, password: nil)).to_not be_valid
  end
  it 'should have many comments' do
    t = User.reflect_on_association(:comments)
    expect(t.macro).to eq(:has_many)
  end
  it 'should have dependent destroy on comment' do
    t = User.reflect_on_association(:comments)
    expect(t.options[:dependent]).to eq(:destroy)
  end
  it 'should have default role as user' do
    expect(FactoryBot.build(:user).role).to eq('user')
  end
  it 'should have valid email' do
    expect(FactoryBot.build(:user).email).to match(/\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i)
  end
  it 'should have a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end
end
