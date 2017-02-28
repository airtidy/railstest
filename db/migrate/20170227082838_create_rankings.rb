class CreateRankings < ActiveRecord::Migration[5.0]
  def change
    create_table :rankings do |t|
      t.references :girl, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rank

      t.timestamps
    end
  end
end
