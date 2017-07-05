class CreateRankings < ActiveRecord::Migration[5.0]
  def change
    create_table :rankings do |t|
      t.references :girl, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rank, default: 0
      t.float :absolute_rank, default: 0.0
      t.timestamps
    end
  end
end
