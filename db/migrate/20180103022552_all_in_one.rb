class AllInOne < ActiveRecord::Migration[5.0]
  def change
    add_column :battles, :total_rounds, :integer, array: true
    add_column :battles, :died_to_plasma, :integer
    change_column_default :battles,  :invulnerable, 0
    change_column_default :battles,  :ap_value, 0
    drop_table :results
  end
end
