# frozen_string_literal: true

# This is comments controller
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, except: [:create]
  before_action :restrict_admin, only: [:create]
  def create
    @artist = Artist.find(params[:artist_id])
    @comment = @artist.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to artist_path(@artist), notice: 'Review has been requested to admin.' }
      else
        format.html { redirect_to artist_path(@artist), status: :unprocessable_entity, alert: 'Invalid Comment' }
      end
    end
  end

  def destroy
    @artist = Artist.find(params[:artist_id])
    @comment = @artist.comments.find(params[:id])
    @comment.destroy
    redirect_to artist_path(@artist), status: :see_other, alert: 'Comment has been deleted.'
  end

  def accept
    @comment = Comment.find(params[:id])
    @comment.update(approval: true)
    redirect_to requests_path, notice: 'Review Approved.'
  end

  def reject
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to requests_path, alert: 'Review Rejected'
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :rating)
  end

  def restrict_admin
    @artist = Artist.find(params[:artist_id])
    return unless current_user.admin?

    redirect_to artist_path(@artist), status: :unprocessable_entity,
                                      alert: 'You are not allowed to perform this action.'
  end
end
