class SavedColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :battles, :saved, :boolean, default: false
  end
end
