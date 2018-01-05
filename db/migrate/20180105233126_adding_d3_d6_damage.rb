class AddingD3D6Damage < ActiveRecord::Migration[5.0]
  def change
    add_column :battles, :d3_damage, :string
    add_column :battles, :d6_damage, :string
  end
end
