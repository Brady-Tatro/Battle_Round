module Plasma

  def plasma_to_hit
    models_to_shoot = @attacking_models
    total_hits = 0
    while models_to_shoot > 0
      ones_rolled = 0
      rerolled_shots = 0
      rolled_shots << roll(@shots)
      rolled_shots.each do |check|
        if check == 1
          ones_rolled += 1
        end
      end
      if @battle_data["reroll1_hits"] == 1
        rolled_shots.each do |ones|
          if ones == 1
            rerolled_shots += 1
            ones_rolled += 1
          end
        end
      elsif @battle_data["reroll_hits"] == 1
        rolled_shots.each do |misses|
          if misses < @ballistic_skill
            if misses == 1
              rerolled_shots += 1
              ones_rolled += 1
            else
              rerolled_shots += 1
            end
          end
        end
      end
    end
  end
  neg_one
end
