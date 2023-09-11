# frozen_string_literal: true

# Adding Rating to comment table
class AddRatingToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :rating, :integer
  end
end
