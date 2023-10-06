# frozen_string_literal: true

# Tests for CommentsController
require 'rails_helper'

RSpec.describe 'Comments', type: :request do # rubocop:disable Metrics/BlockLength
  before do
    @artist = FactoryBot.create(:artist)
    @comment = FactoryBot.create(:comment, artist: @artist)
    @admin_user = User.create(email: 'admin@user.com', password: 'King@123', role: 'admin')
    @normal_user = User.create(email: 'normal@user.com', password: 'King@123', role: 'user')
  end

  context 'when user is logged in' do
    it 'should create comment' do
      sign_in @normal_user
      post artist_comments_path(@artist), params: { comment: { body: 'This is a comment', rating: 5 } }
      expect(response).to have_http_status(:found)
    end
  end

  context 'post /comments' do
    it 'should not create a comment' do
      sign_in @normal_user
      post artist_comments_path(@artist), params: { comment: { body: '' } }
      expect(response.status).to eq(422)
    end

    it 'should create a comment' do
      sign_in @normal_user
      post artist_comments_path(@artist), params: { comment: { body: 'This is a comment', rating: 5 } }
      expect(response.status).to eq(302)
    end
  end

  context 'delete /comments' do
    it 'should delete a comment' do
      sign_in @admin_user
      delete artist_comment_path(@artist, @comment)
      expect(response.status).to eq(303)
    end
  end

  context 'accept /comments' do
    it 'should accept a comment' do
      sign_in @admin_user
      put accept_comment_path(@comment)
      expect(response.status).to eq(302)
    end
  end

  context 'reject /comments' do
    it 'should reject a comment' do
      sign_in @admin_user
      delete reject_comment_path(@comment)
      expect(response.status).to eq(302)
    end
  end

  context 'when user logged in as admin' do
    it 'should not create comment' do
      sign_in @admin_user
      post artist_comments_path(@artist), params: { comment: { body: 'This is a comment', rating: 5 } }
      expect(response.status).to eq(422)
    end
  end
end
