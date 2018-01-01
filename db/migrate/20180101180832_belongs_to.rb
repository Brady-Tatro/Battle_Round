class BelongsTo < ActiveRecord::Migration[5.0]
  def change
    change_table :results do |t|
      t.remove_references :submission
    end
  end
end
