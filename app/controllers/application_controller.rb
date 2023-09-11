# frozen_string_literal: true

# This is the parent controller of the application and all other controller inherit from this controller
class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @q = Artist.ransack(params[:q])
  end

  def require_admin
    render json: { message: 'Unauthorized' }, status: :unauthorized unless current_user.admin?
  end
end
