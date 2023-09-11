# frozen_string_literal: true

# Creating artist table
class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :dob
      t.string :location
      t.string :work
      t.string :email

      t.timestamps
    end
  end
end
