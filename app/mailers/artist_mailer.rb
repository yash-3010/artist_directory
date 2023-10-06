# frozen_string_literal: true

# This is artist mailer
class ArtistMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.artist_mailer.mail_artist.subject
  #
  def mail_artist
    @reciver = params[:reciver]
    @sender = params[:sender]
    @body = params[:body]

    mail(
      to: @reciver,
      subject: 'Intrest shown in your work',
      from: @sender
    )
  end
end
