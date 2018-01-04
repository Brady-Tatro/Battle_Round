class ChangeTableName < ActiveRecord::Migration[5.0]
  def change
    rename_table :sumbissions, :battles
  end
end
