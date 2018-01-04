class AddWounds < ActiveRecord::Migration[5.0]
  def change
    change_table :battles do |t|
      t.integer :wounds, null: false
    end
  end
end
