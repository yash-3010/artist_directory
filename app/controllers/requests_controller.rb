# frozen_string_literal: true

# This is requests controller
class RequestsController < ApplicationController
  before_action :require_admin
  def index
    @comments = Comment.where('approval = false')
  end
end
