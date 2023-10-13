# frozen_string_literal: true

# This is the Link model. It belongs to the Artist model.
class Link < ApplicationRecord
  belongs_to :artist
end
