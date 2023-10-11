# frozen_string_literal: true

# Renaming links array to links in artists table
class RenameLinksArrayToLinksInArtists < ActiveRecord::Migration[7.0]
  def change
    rename_column :artists, :links_json, :links
  end
end
