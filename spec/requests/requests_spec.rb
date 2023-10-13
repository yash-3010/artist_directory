# frozen_string_literal: true

# Tests for RequestsController
require 'rails_helper'

RSpec.describe 'Requests', type: :request do
  before do
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'only admin can access index page of requests' do
    it 'should not allow normal user to access index page of requests' do
      sign_in @normal_user
      get requests_path
      expect(response.status).to eq(401)
    end

    it 'should allow admin to access index page of requests' do
      sign_in @admin_user
      get requests_path
      expect(response.status).to eq(200)
    end
  end
end
