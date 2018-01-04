class Submissions < ActiveRecord::Migration[5.0]
  def change
    create_table :sumbissions do |t|
      t.integer :attack_models,  null: false
      t.integer :shots, null: false
      t.integer :ballistic_skill, null: false
      t.integer :weapon_strength, null: false
      t.integer :damage, null: false
      t.integer :ap_value, null: false
      t.integer :defend_models, null: false
      t.integer :toughness, null: false
      t.integer :armor, null: false
      t.integer :invulnerable, null: false
      t.integer :leadership, null: false
      t.integer :times_run, null: false
      t.string :d3
      t.string :d6
      t.string :plasma
      t.string :always_hit
      t.string :sniper
      t.string :neg1_to_hit_attack
      t.string :neg1_to_hit_defend
      t.string :plus1_to_hit
      t.string :reroll_hits
      t.string :reroll1_hits
      t.string :reroll_wounds
      t.string :reroll1_wounds
    end
  end
end
