class CreateGirls < ActiveRecord::Migration[5.0]
  def change
    create_table :girls do |t|
      t.string :name
      t.integer :age
      t.float :global_sum_absolute_ranks, default: 0.0
      t.integer :global_sum_relative_ranks, default: 0

      t.timestamps
    end
  end
end
