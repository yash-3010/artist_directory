# frozen_string_literal: true

# This is comment model
class Comment < ApplicationRecord
  belongs_to :artist
  validates :body, presence: true
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :approval, inclusion: { in: [true, false] }
  validates :approval, exclusion: { in: [nil] }
  belongs_to :user

  def blank_stars
    5 - rating.to_i
  end

  after_initialize :set_default_approval, if: :new_record?

  def set_default_approval
    self.approval ||= false
  end
end
