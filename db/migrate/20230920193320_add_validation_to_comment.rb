# frozen_string_literal: true

# Adding db level validation to comment model
class AddValidationToComment < ActiveRecord::Migration[7.0]
  def change
    change_column_null :comments, :body, false
    change_column_null :comments, :rating, false
    change_column_default :comments, :approval, false
  end
end
