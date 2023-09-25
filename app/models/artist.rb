# frozen_string_literal: true

# This is artist model
class Artist < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :category_id, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  belongs_to :category
  has_one_attached :image
  has_many_attached :pictures
  validate :image_type
  validate :pictures_type

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id created_at dob email id links location name updated_at work]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category comments]
  end

  private

  def image_type
    errors.add(:image, 'is missing!') if image.attached? == false
    return unless image.attached? == true

    errors.add(:image, 'needs to be a JPEG or PNG') unless image.content_type.in?(%w[image/jpeg image/png])
  end

  def pictures_type
    errors.add(:pictures, 'are missing!') if pictures.attached? == false
    return unless pictures.attached? == true

    pictures.each do |picture|
      errors.add(:pictures, 'needs to be a JPEG or PNG') unless picture.content_type.in?(%w[image/jpeg image/png])
    end
  end
end
