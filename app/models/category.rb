# frozen_string_literal: true

# This is category model
class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :artists, dependent: :destroy
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at]
  end
end
