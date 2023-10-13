# frozen_string_literal: true

# Tests for CategoriesController
require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before do
    @category = Category.create(name: 'Sports')
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'POST /categories' do
    it 'should create a new category' do
      sign_in @admin_user
      post categories_path, params: { category: { name: 'Travel' } }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(category_path(Category.last))
    end

    it 'should not create a new category' do
      sign_in @admin_user
      post categories_path, params: { category: { name: '' } }
      expect(response.status).to eq(422)
    end
  end
end

RSpec.describe 'Categories', type: :request do
  before do
    @category = Category.create(name: 'Sports')
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'GET /categories' do
    it 'should get categories index' do
      sign_in @admin_user
      get categories_path
      expect(response.status).to eq(200)
      render_template(:index)
    end

    it 'should get new' do
      sign_in @admin_user
      get new_category_path
      expect(response.status).to eq(200)
      render_template(:new)
    end
  end
end
RSpec.describe 'Categories', type: :request do
  before do
    @category = Category.create(name: 'Sports')
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'GET /categories' do
    it 'should get show' do
      sign_in @admin_user
      get category_path(@category)
      expect(response.status).to eq(200)
      render_template(:show)
    end

    it 'should get edit' do
      sign_in @admin_user
      get edit_category_path(@category)
      expect(response.status).to eq(200)
      render_template(:edit)
    end
  end
end

RSpec.describe 'Categories', type: :request do
  before do
    @category = Category.create(name: 'Sports')
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'Non-admin user' do
    it 'should not create when admin not logged in' do
      sign_in @normal_user
      post categories_path, params: { category: { name: 'Travel' } }
      expect(response.status).to eq(401)
    end

    it 'should not update when admin not logged in' do
      sign_in @normal_user
      put category_path(@category), params: { category: { name: 'Travel' } }
      expect(response.status).to eq(401)
    end

    it 'should not destroy when admin not logged in' do
      sign_in @normal_user
      delete category_path(@category)
      expect(response.status).to eq(401)
    end
  end
end

RSpec.describe 'Categories', type: :request do
  before do
    @category = Category.create(name: 'Sports')
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'PUT /categories' do
    it 'should update a category' do
      sign_in @admin_user
      put category_path(@category), params: { category: { name: 'Travel' } }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(category_path(@category))
    end

    it 'should not update a category' do
      sign_in @admin_user
      put category_path(@category), params: { category: { name: '' } }
      expect(response.status).to eq(422)
    end
  end
end

RSpec.describe 'Categories', type: :request do
  before do
    @category = Category.create(name: 'Sports')
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'DELETE /categories' do
    it 'should delete a category' do
      sign_in @admin_user
      delete category_path(@category)
      expect(response.status).to eq(302)
      expect(response).to redirect_to(categories_path)
    end
  end
end
