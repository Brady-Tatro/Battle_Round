class Results < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.belongs_to :submission
      t.integer :total_rounds, array: true
      t.integer :died_to_plasma
    end
  end
end
