# frozen_string_literal: true

# Adding db level validation to artist model
class AddValdationToArtist < ActiveRecord::Migration[7.0]
  def change
    change_column_null :artists, :name, false
    change_column_null :artists, :email, false
    add_index :artists, :email, unique: true
  end
end
