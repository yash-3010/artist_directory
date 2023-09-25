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
end

RSpec.describe User, type: :model do
  it 'should have default role as user' do
    expect(FactoryBot.build(:user).role).to eq('user')
  end
  it 'should have valid email' do
    expect(FactoryBot.build(:user).email).to match(/\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i)
  end
  it 'should have a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end
  it 'should have unique email' do
    FactoryBot.create(:user, email: 'unique@mail.com')
    expect(FactoryBot.build(:user, email: 'unique@mail.com')).to_not be_valid
  end
end

RSpec.describe User, type: :model do
  context 'should not be valid when' do
    it 'email is not present' do
      expect(FactoryBot.build(:user, email: nil)).to_not be_valid
    end
    it 'password is not present' do
      expect(FactoryBot.build(:user, password: nil)).to_not be_valid
    end
    it 'email is not unique' do
      FactoryBot.create(:user, email: 'unique@mail.com')
      expect(FactoryBot.build(:user, email: 'unique@mail.com')).to_not be_valid
    end
    it 'email is not valid' do
      expect(FactoryBot.build(:user, email: 'invalid')).to_not be_valid
    end
    it 'password is less than 6 characters' do
      expect(FactoryBot.build(:user, password: '12345')).to_not be_valid
    end
    it 'password is more than 128 characters' do
      expect(FactoryBot.build(:user, password: 'a' * 129)).to_not be_valid
    end
  end
end
