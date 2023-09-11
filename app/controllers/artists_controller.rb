# frozen_string_literal: true

# This is artist controller
class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show edit update destroy]
  before_action :set_categories
  before_action :require_admin, except: %i[show index sendmail mails]
  before_action :authenticate_user!, only: %i[sendmail mails]

  # GET /artists or /artists.json
  def index
    @rating_filter = params[:rating_filter].to_i
    @artists = if @rating_filter.zero?
                 @q.result(distinct: true).order(:name)
               else
                 @q.result(distinct: true).order(:name).joins(:comments).group('artists.id').having(
                   'AVG(CASE WHEN comments.approval = TRUE THEN comments.rating ELSE NULL END) > ?', @rating_filter
                 )
               end
  end

  def search
    @rating_filter = params[:rating_filter].to_i
    @artists = @q.result(distinct: true).order(:name).joins(:comments).group('artists.id').having(
      'AVG(CASE WHEN comments.approval = TRUE THEN comments.rating ELSE NULL END) > ?', @rating_filter
    )
    render turbo_stream: turbo_stream.replace('results', partial: 'artists/results')
  end

  # GET /artists/1 or /artists/1.json
  def show
    @approved_comments = Comment.where(artist_id: @artist.id, approval: true)
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit; end

  # POST /artists or /artists.json
  def create
    @artist = Artist.new(artist_params)
    respond_to do |format|
      if @artist.save
        format.html { redirect_to artist_url(@artist), notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1 or /artists/1.json
  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to artist_url(@artist), notice: 'Artist was successfully updated.' }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1 or /artists/1.json
  def destroy
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mails
    render 'artists/mails'
  end

  def sendmail
    @artist = Artist.find(params[:id])
    @body = params[:content]

    respond_to do |format|
      ArtistMailer.with(reciver: @artist.email, sender: current_user.email, body: @body).mail_artist.deliver_now
      format.html { redirect_to artist_url(@artist), notice: 'Email sent successfully' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_artist
    @artist = Artist.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def artist_params
    params.require(:artist).permit(:name, :dob, :location, :work, :email, :category_id, :links, :content, :image,
                                   pictures: [])
  end

  def set_categories
    @categories = Category.all.order(:name)
  end
end
