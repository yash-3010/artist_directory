# frozen_string_literal: true

# Changing links type in artists table
class ChangeLinksTypeInArtists < ActiveRecord::Migration[7.0]
  def change
    change_column :artists, :links, :text
    add_column :artists, :links_json, :text, default: '[]'
  end
end
