module BattleRound

  def battle(battle_data)
    @battle_data = battle_data
    @round = 0
    @defending_models = @battle_data["defend_models"].to_i
    @attacking_models = @battle_data["attack_models"].to_i
    @shots = @battle_data["shots"].to_i
    @ballistic_skill = @battle_data["ballistic_skill"].to_i
    @weapon_strength = @battle_data["weapon_strength"].to_i
    @toughness = @battle_data["toughness"].to_i
    @armour = @battle_data["armour"].to_i
    @invulnerable = @battle_data["invulnerable"].to_i
    @ap_value = @battle_data["ap_value"].to_i
    @damage = @battle_data["damage"].to_i
    @wounds = @battle_data["wounds"].to_i

    while @defending_models > 0 do
      to_hit
      to_wound
      saving_throw
      @round += 1
      if @battle_data["times_run"].to_i >= 10 && @round == 100
        break
      end
    end
    return @round
  end

  def to_hit
    @total_shots = @attacking_models * @shots
    @rolled_shots = roll(@total_shots)
    if @battle_data["plus1_to_hit"] == "1"
      @rolled_shots.delete_if { |hit| hit + 1 < @ballistic_skill }
    elsif @battle_data["neg1_to_hit_attack"] || @battle_data["neg1_to_hit_defend"] == "1"
      @rolled_shots.delete_if { |hit| hit - 1 < @ballistic_skill }
    elsif @battle_data["neg1_to_hit_attack"] && @battle_data["neg1_to_hit_defend"] == "1"
      @rolled_shots.delete_if { |hit| hit - 2 < @ballistic_skill }
    else
      @rolled_shots.delete_if { |hit| hit < @ballistic_skill }
    end
    @hits = @rolled_shots.length
  end

  def to_wound
    if @hits > 0
      @wounds = roll(@hits)
      if @weapon_strength >= @toughness * 2
        @wounds.delete_if { |wound| wound < 2 }
      elsif @weapon_strength > @toughness
        @wounds.delete_if { |wound| wound < 3 }
      elsif @weapon_strength == @toughness
        @wounds.delete_if { |wound| wound < 4 }
      elsif @weapon_strength <= @toughness / 2
        @wounds.delete_if { |wound| wound < 6 }
      elsif @weapon_strength < @toughness
        @wounds.delete_if { |wound| wound < 5 }
      end
    end
    @rolled_wounds = @wounds.length
  end

  def saving_throw
    if @rolled_wounds > 0
      @saved = roll(@rolled_wounds)
      @original = @saved.length
      @saved.delete_if { |save| save < @armour && @invulnerable }
      if @ap_value > 0
        if @invulnerable > @armour - @ap_value
          @saved.delete_if { |save| save < @invulnerable  }
        else
          @saved.delete_if { |save| save - @ap_value < @armour  }
        end
      end
      if @saved.nil?
        @damaged = @original
      else
        @damaged = @original - @saved.length
      end
      current_wounds = 0
      while @damaged > 0
        current_wounds += @damage
          if current_wounds >= @wounds
            @defending_models = @defending_models - 1
            current_wounds = 0
          end
        @damaged -= 1
      end
    end
  end

  def roll(num)
    result = []
    num.times do
      result << rand(6) + 1
    end
    return result
  end
  
end
