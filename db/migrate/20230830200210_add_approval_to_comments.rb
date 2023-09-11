# frozen_string_literal: true

# Adding approval column to comments table
class AddApprovalToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :approval, :boolean
  end
end
