# frozen_string_literal: true

# This is artist controller
class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show edit update destroy]
  before_action :set_categories
  before_action :require_admin, except: %i[show index sendmail mails]
  before_action :authenticate_user!, only: %i[sendmail mails show]

  # GET /artists or /artists.json
  def index
    @rating_filter = params[:rating_filter].to_i
    @rating_sort = params[:rating_sort].to_i # rating_sort 0 means no sort, 1 means ascending, 2 means descending

    # Retrieve all artists
    @artists = @q.result(distinct: true).joins('LEFT JOIN comments ON comments.artist_id
     = artists.id AND comments.approval = true').group('artists.id')

    # Filter artists based on rating filter
    @artists = @artists.having('AVG(comments.rating) > ?', @rating_filter) if @rating_filter.positive?

    # Sort the artists based on rating_sort
    if @rating_sort != 0
      @artists = @artists.order("AVG(comments.rating) #{@rating_sort == 1 ? 'ASC' : 'DESC'}").references(:comments)
    end

    # Then sort by name if rating_sort is 0
    @artists = @artists.sort_by(&:name) if @rating_sort.zero? && @rating_filter.zero?

    return unless @rating_sort.zero? && @rating_filter.zero?

    @artists = @q.result(distinct: true).order(:name)
  end


  # def search
  #   @rating_filter = params[:rating_filter].to_i
  #   @artists = @q.result(distinct: true).order(:name).joins(:comments).group('artists.id').having(
  #     'AVG(CASE WHEN comments.approval = TRUE THEN comments.rating ELSE NULL END) > ?', @rating_filter
  #   )
  #   render turbo_stream: turbo_stream.replace('results', partial: 'artists/results')
  # end

  # GET /artists/1 or /artists/1.json
  def show
    @approved_comments = Comment.where(artist_id: @artist.id, approval: true)
  end

  # GET /artists/new
  def new
    @artist = Artist.new
    @artist.links.build
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
      format.html { redirect_to artists_url, alert: 'Artist was destroyed successfully.' }
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
    params.require(:artist).permit(:name, :dob, :location, :work, :email, :category_id, :content, :image,
                                   pictures: [], links_attributes: %i[id url _destroy])
  end

  def set_categories
    @categories = Category.all.order(:name)
  end
end
