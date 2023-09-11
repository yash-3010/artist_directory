# frozen_string_literal: true

require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'should not save artist without category_id' do
    artist = Artist.new
    assert_not artist.save
  end
end
