# frozen_string_literal: true

# This is comment model
class Comment < ApplicationRecord
  belongs_to :artist
  validates :body, presence: true
  validates :rating, presence: true
  belongs_to :user

  def blank_stars
    5 - rating.to_i
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[artist_id body user_id created_at id rating updated_at]
  end

  after_initialize :set_default_approval, if: :new_record?

  def set_default_approval
    self.approval ||= false
  end
end
