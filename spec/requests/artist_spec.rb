# frozen_string_literal: true

# Tests for ArtistsController
require 'rails_helper'

RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'PUT /artists' do
    it 'should update a artist' do
      sign_in @admin_user
      put artist_path(@artist),
          params: { artist: { name: 'Artist 2', email: 'artist@dmain.com', id: 1, category_id: 1 } }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(artist_path(@artist))
    end

    it 'should not update a artist' do
      sign_in @admin_user
      put artist_path(@artist), params: { artist: { name: '' } }
      expect(response.status).to eq(422)
    end
  end
end

RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'check index' do
    it 'assigns @rating_filter as 0 when rating_filter param is not provided' do
      get artists_path
      expect(response.body).to include('0')
    end

    it 'assigns @artists with the correct query when rating_filter is 0' do
      artist1 = FactoryBot.create(:artist, email: 'artist1@user.com')
      artist2 = FactoryBot.create(:artist, email: 'artist2@usr.com')

      get artists_path

      expect(response.body).to include(artist1.name)
      expect(response.body).to include(artist2.name)
    end
  end
end
RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'check index' do
    it 'assigns @artists with the correct query when rating_filter is not 0' do
      artist1 = FactoryBot.create(:artist, email: 'artist1@user.com')
      artist2 = FactoryBot.create(:artist, email: 'artist2@usr.com')
      FactoryBot.create(:comment, artist: artist1, approval: true, rating: 3)
      FactoryBot.create(:comment, artist: artist2, approval: true, rating: 5)

      get artists_path, params: { rating_filter: 4 }

      expect(response.body).not_to include(artist1.name)
      expect(response.body).to include(artist2.name)
    end
  end
end

RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  it 'sorts artists by average rating in ascending order when rating_sort is 1' do
    artist1 = create(:artist)
    artist2 = create(:artist)
    create(:comment, artist: artist1, rating: 3, approval: true)
    create(:comment, artist: artist2, rating: 4, approval: true)
    get '/artists', params: { rating_sort: '1' }

    expect(response).to have_http_status(200)
    expect(response.body).to include(artist1.name)
    expect(response.body).to include(artist2.name)
  end

  it 'sorts artists by average rating in descending order when rating_sort is not 1' do
    artist1 = create(:artist)
    artist2 = create(:artist)
    create(:comment, artist: artist1, rating: 3, approval: true)
    create(:comment, artist: artist2, rating: 4, approval: true)
    get '/artists', params: { rating_sort: '2' }

    expect(response).to have_http_status(200)
    expect(response.body).to include(artist2.name)
    expect(response.body).to include(artist1.name)
  end
end

RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'GET /artists' do
    it 'should get artists index' do
      sign_in @admin_user
      get artists_path
      expect(response.status).to eq(200)
      render_template(:index)
    end

    it 'should get new' do
      sign_in @admin_user
      get new_artist_path
      expect(response.status).to eq(200)
      render_template(:new)
    end
  end
end

RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'GET /artists' do
    it 'should get show' do
      sign_in @admin_user
      get artist_path(@artist)
      expect(response.status).to eq(200)
      redirect_to(artist_path(@artist))
    end

    it 'should get edit' do
      sign_in @admin_user
      get edit_artist_path(@artist)
      expect(response.status).to eq(200)
      redirect_to(edit_artist_path(@artist))
    end
  end
end

RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'POST /artists' do
    it 'should create a artist' do
      sign_in @admin_user
      cat = FactoryBot.create(:category)
      image_file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/a1.jpg'), 'image/jpeg')
      pictures_files = [Rack::Test::UploadedFile.new(Rails.root.join('spec/assets/images/p1.jpg'), 'image/jpeg')]
      artist_attributes = attributes_for(:artist, category_id: cat.id)
      artist_attributes[:image] = image_file
      artist_attributes[:pictures] = pictures_files
      post artists_path, params: { artist: artist_attributes }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(artist_path(Artist.last))
    end
    it 'should not create a artist' do
      sign_in @admin_user
      post artists_path, params: { artist: { name: '' } }
      expect(response.status).to eq(422)
    end
  end
end

RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'normal user should not be able to access' do
    it 'should not get new' do
      sign_in @normal_user
      get new_artist_path
      expect(response.status).to eq(401)
    end

    it 'should not get edit' do
      sign_in @normal_user
      get edit_artist_path(@artist)
      expect(response.status).to eq(401)
    end

    it 'should not create a artist' do
      sign_in @normal_user
      post artists_path, params: { artist: { name: '' } }
      expect(response.status).to eq(401)
    end
  end
end

RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'DELETE /artists' do
    it 'should delete a artist' do
      sign_in @admin_user
      delete artist_path(@artist)
      expect(response.status).to eq(302)
      expect(response).to redirect_to(artists_path)
    end
  end
end

RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'mail artist' do
    it 'normal user can see mail artist page if signed in' do
      sign_in @normal_user
      get mails_artist_path(@artist)
      expect(response.status).to eq(200)
      render_template(:mails)
    end

    it 'normal user can should send mail to artist' do
      sign_in @normal_user
      get sendmail_artist_path(@artist), params: { content: 'Test mail' }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(artist_path(@artist))
    end
  end
end

RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'normal user should be able to access' do
    it 'should get artists index' do
      sign_in @normal_user
      get artists_path
      expect(response.status).to eq(200)
      render_template(:index)
    end

    it 'should get show' do
      sign_in @normal_user
      get artist_path(@artist)
      expect(response.status).to eq(200)
      redirect_to(artist_path(@artist))
    end
  end
end

RSpec.describe 'Artists', type: :request do
  before do
    @artist = FactoryBot.create(:artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin', username: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user', username: 'normal')
  end

  context 'normal user should not be able to access' do
    it 'should not update a artist' do
      sign_in @normal_user
      put artist_path(@artist),
          params: { artist: { name: 'Artist 2', email: 'artist@domain.com', id: 1, category_id: 1 } }
      expect(response.status).to eq(401)
    end

    it 'should not delete a artist' do
      sign_in @normal_user
      delete artist_path(@artist)
      expect(response.status).to eq(401)
    end
  end
end
