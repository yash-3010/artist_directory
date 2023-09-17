# frozen_string_literal: true

# Adding index to categories name
class AddIndexToCategoriesName < ActiveRecord::Migration[7.0]
  def change
    add_index :categories, :name, unique: true
  end
end
