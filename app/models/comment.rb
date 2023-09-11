# frozen_string_literal: true

# This is comment model
class Comment < ApplicationRecord
  belongs_to :artist
  validates :commenter, presence: true
  validates :body, presence: true
  validates :rating, presence: true

  def blank_stars
    5 - rating.to_i
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[artist_id body commenter created_at id rating updated_at]
  end

  after_initialize :set_default_approval, if: :new_record?

  def set_default_approval
    self.approval ||= false
  end
end
