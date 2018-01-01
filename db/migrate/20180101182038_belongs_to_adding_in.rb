class BelongsToAddingIn < ActiveRecord::Migration[5.0]
  def change
    change_table :results do |t|
      t.belongs_to :battle
    end
  end
end
