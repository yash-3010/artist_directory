# frozen_string_literal: true

require 'test_helper'

class ArtistMailerTest < ActionMailer::TestCase
  test 'mail_artist' do
    mail = ArtistMailer.mail_artist
    assert_equal 'Mail artist', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end
end
