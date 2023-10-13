# frozen_string_literal: true

# This is the test for the Users::RegistrationsController.
require 'rails_helper'

RSpec.describe 'Users::RegistrationsController', type: :request do
  let(:user) { create(:user) }

  describe 'GET #new' do
    it 'returns a success response' do
      get new_user_registration_path
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new user' do
      post user_registration_path, params: { user: attributes_for(:user) }
      expect(User.count).to eq(1)
      expect(response).to redirect_to(root_path)
    end
  end
end

RSpec.describe 'Users::RegistrationsController', type: :request do
  let(:user) { create(:user) }

  describe 'GET #edit' do
    it 'returns a success response' do
      sign_in user
      get edit_user_registration_path
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    it 'updates the user when the current password is provided' do
      normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
      sign_in normal_user
      put user_registration_path, params: { user: { username: 'user', current_password: 'King@123' } }
      expect(response.status).to eq(303)
      expect(response).to redirect_to(root_path)
    end
  end
end
