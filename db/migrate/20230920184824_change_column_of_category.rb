# frozen_string_literal: true

# Adding null constraint to category name
class ChangeColumnOfCategory < ActiveRecord::Migration[7.0]
  def change
    change_column_null :categories, :name, false
  end
end
