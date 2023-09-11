# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/artist_mailer
class ArtistMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/artist_mailer/mail_artist
  def mail_artist
    ArtistMailer.with(reciver: 'artist@example.com', sender: 'user@example.com', body: 'test').mail_artist
  end
end
