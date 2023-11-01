class CreateDescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :descriptions do |t|
      t.text :text
      t.string :division
      t.references :workout, null: false, foreign_key: true

      t.timestamps
    end
  end
end
