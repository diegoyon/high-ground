class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.references :athlete, null: false, foreign_key: true
      t.references :workout, null: false, foreign_key: true
      t.jsonb :score_data

      t.timestamps
    end
  end
end
