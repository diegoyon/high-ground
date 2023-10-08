class AddCappedToScore < ActiveRecord::Migration[7.0]
  def change
    add_column :scores, :capped, :boolean, default: false
  end
end
