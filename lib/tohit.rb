module ToHit

  def to_hit
    @total_shots = 0
    numberOfShots
    if @battle_data["always_hit"] == "1"
      @hits = @total_shots
    else
      @rolled_shots = roll(@total_shots)
      rerolled_shots = 0
      if @battle_data["reroll1_hits"] == "1"
        @rolled_shots.each do |ones|
          if ones == 1
            rerolled_shots += 1
          end
        end
        @rolled_shots << roll(rerolled_shots)
        @rolled_shots.flatten!
        @rolled_shots.delete_if { |hit| hit < @ballistic_skill }
      elsif @battle_data["reroll_hits"] == "1"
        @rolled_shots.each do |misses|
          if misses < @ballistic_skill
            rerolled_shots += 1
          end
        end
        @rolled_shots << roll(rerolled_shots)
        @rolled_shots.flatten!
        @rolled_shots.delete_if { |hit| hit < @ballistic_skill }
      end

      if @battle_data["plus1_to_hit"] == "1"
        @rolled_shots.delete_if { |hit| hit + 1 < @ballistic_skill }
      elsif @battle_data["neg1_to_hit_attack"] && @battle_data["neg1_to_hit_defend"] == "1"
        @rolled_shots.delete_if { |hit| hit - 1 < @ballistic_skill }
      elsif @battle_data["neg1_to_hit_attack"] || @battle_data["neg1_to_hit_defend"] == "1"
        @rolled_shots.delete_if { |hit| hit - 2 < @ballistic_skill }
      else
        @rolled_shots.delete_if { |hit| hit < @ballistic_skill }
      end
      @hits = @rolled_shots.length
    end
  end

  def numberOfShots
    if @battle_data["d3"] == "1"
      @attacking_models.times do
        @shots.times do
          @total_shots += d3
        end
      end
    elsif @battle_data["d6"] == "1"
      @attacking_models.times do
        @shots.times do
          @total_shots += d6
        end
      end
    else
      @total_shots = @attacking_models * @shots
    end
  end

end
