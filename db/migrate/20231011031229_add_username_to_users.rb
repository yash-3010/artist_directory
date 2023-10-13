# frozen_string_literal: true

# Adding username to users table
class AddUsernameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string, null: false
  end
end
