class Battle < ApplicationRecord

validates :ballistic_skill, :armour, :inclusion => 2..7
validates :attack_models, :shots, :weapon_strength, :damage, :defend_models, :toughness, :leadership, :times_run, numericality: { other_than: 0 }

end
