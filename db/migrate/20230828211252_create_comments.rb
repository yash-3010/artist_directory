# frozen_string_literal: true

# Creating comment table
class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.string :body
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
