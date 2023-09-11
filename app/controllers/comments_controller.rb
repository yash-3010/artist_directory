# frozen_string_literal: true

# This is comments controller
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:create]
  def create
    @artist = Artist.find(params[:artist_id])
    @comment = @artist.comments.create(comment_params)
    redirect_to artist_path(@artist), notice: 'Review Requested'
  end

  def destroy
    @artist = Artist.find(params[:artist_id])
    @comment = @artist.comments.find(params[:id])
    @comment.destroy
    redirect_to artist_path(@artist), status: :see_other
  end

  def accept
    @comment = Comment.find(params[:id])
    @comment.update_attribute(:approval, true)
    redirect_to artists_path, notice: 'Review Approved'
  end

  def reject
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to artists_path, notice: 'Review Rejected'
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :rating)
  end
end
