# frozen_string_literal: true

# Changed dob from string to date
class ChangeDobFromArtist < ActiveRecord::Migration[7.0]
  def change
    change_column :artists, :dob, :date
  end
end
