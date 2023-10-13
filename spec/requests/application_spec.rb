# frozen_string_literal: true

# Tests for application controller
require 'rails_helper'

RSpec.describe 'Application', type: :request do
  before do
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'require_admin' do
    it 'should return unauthorized' do
      sign_in @normal_user
      get requests_path
      expect(response.status).to eq(401)
    end

    it 'should return ok' do
      sign_in @admin_user
      get requests_path
      expect(response.status).to eq(200)
    end
  end
end
