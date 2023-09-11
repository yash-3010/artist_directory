# frozen_string_literal: true

# Associating categories to artist
class AddCategoryToArtists < ActiveRecord::Migration[7.0]
  def change
    add_reference :artists, :category, null: false, foreign_key: true
  end
end
