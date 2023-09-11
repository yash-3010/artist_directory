# frozen_string_literal: true

# Migration responsible for dropping services table
class DropServices < ActiveRecord::Migration[7.0]
  def change
    drop_table :services
  end
end
