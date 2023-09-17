# frozen_string_literal: true

# Remove the commenter column from the comments table and add a user_id column
class RemoveCommenterFromComments < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.remove :commenter
      t.references :user, null: false, foreign_key: true
    end
  end
end
