# frozen_string_literal: true

require 'test_helper'

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artist = artists(:one)
  end

  test 'should get index' do
    get artists_url
    assert_response :success
  end

  test 'should get new' do
    get new_artist_url
    assert_response :success
  end

  test 'should create artist' do
    assert_difference('Artist.count') do
      post artists_url,
           params: { artist: { dob: @artist.dob, email: @artist.email, location: @artist.location, name: @artist.name,
                               work: @artist.work } }
    end

    assert_redirected_to artist_url(Artist.last)
  end

  test 'should show artist' do
    get artist_url(@artist)
    assert_response :success
  end

  test 'should get edit' do
    get edit_artist_url(@artist)
    assert_response :success
  end

  test 'should update artist' do
    patch artist_url(@artist),
          params: { artist: { dob: @artist.dob, email: @artist.email, location: @artist.location, name: @artist.name,
                              work: @artist.work } }
    assert_redirected_to artist_url(@artist)
  end

  test 'should destroy artist' do
    assert_difference('Artist.count', -1) do
      delete artist_url(@artist)
    end

    assert_redirected_to artists_url
  end
end
