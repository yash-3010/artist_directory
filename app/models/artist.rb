# frozen_string_literal: true

# This is artist model
class Artist < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :links, dependent: :destroy, inverse_of: :artist
  accepts_nested_attributes_for :links, allow_destroy: true, reject_if: :all_blank
  validates :category_id, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :links, presence: true
  belongs_to :category
  has_one_attached :image
  has_many_attached :pictures
  validate :image_type
  validate :pictures_type
  validate :validate_youtube_urls
  serialize :links, JSON
  before_save :downcase_name

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

  def downcase_name
    self.name = name.downcase
  end

  def validate_youtube_urls
    return if links.blank?

    links.each do |url|
      errors.add(:links, "#{url.url} is not a valid YouTube video URL") unless valid_youtube_url?(url.url)
    end
  end

  def valid_youtube_url?(url)
    youtube_url_regex = %r{\A(?:https?://)?(?:www\.)?(?:youtube\.com/watch\?v=|youtu\.be/)([a-zA-Z0-9_-]+)\z}
    !!url.match(youtube_url_regex)
  end
end
