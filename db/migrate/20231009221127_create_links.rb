# frozen_string_literal: true

# this is the link model
class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :url
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
