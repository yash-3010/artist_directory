# frozen_string_literal: true

# This is artist model
class Artist < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :category_id, presence: true
  validates :image, presence: true
  belongs_to :category
  has_one_attached :image
  has_many_attached :pictures

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id created_at dob email id links location name updated_at work]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category comments]
  end
end
