# frozen_string_literal: true

# This is requests controller
class RequestsController < ApplicationController
  def index
    @comments = Comment.where('approval = false')
  end
end
