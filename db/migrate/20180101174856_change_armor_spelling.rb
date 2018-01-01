class ChangeArmorSpelling < ActiveRecord::Migration[5.0]
  def change
    change_table :battles do |t|
      t.rename :armor, :armour 
    end
  end
end
