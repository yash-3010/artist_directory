# frozen_string_literal: true

# Removing links from artists table
class RemoveLinksFromArtists < ActiveRecord::Migration[7.0]
  def change
    remove_column :artists, :links, :string
  end
end
