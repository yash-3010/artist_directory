# frozen_string_literal: true

# Change links to not null in artists
class ChangeLinksToNotNullInArtists < ActiveRecord::Migration[7.0]
  def change
    change_column_null :artists, :links, false
  end
end
