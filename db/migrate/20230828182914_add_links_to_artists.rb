# frozen_string_literal: true

# Adding links column to artist table.
class AddLinksToArtists < ActiveRecord::Migration[7.0]
  def change
    add_column :artists, :links, :string
  end
end
