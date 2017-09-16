module Validation

  def Validation(validation_data)
    validation_arry = []
    validation_arry << @defending_models = @battle_data["defend_models"].to_i
    validation_arry << @attacking_models = @battle_data["attack_models"].to_i
    validation_arry << @shots = @battle_data["shots"].to_i
    validation_arry << @ballistic_skill = @battle_data["ballistic_skill"].to_i
    validation_arry << @weapon_strength = @battle_data["weapon_strength"].to_i
    validation_arry << @toughness = @battle_data["toughness"].to_i
    validation_arry << @armour = @battle_data["armour"].to_i
    validation_arry << @damage = @battle_data["damage"].to_i
    validation_arry << @hp = @battle_data["wounds"].to_i
    @invulnerable = @battle_data["invulnerable"].to_i
    @ap_value = @battle_data["ap_value"].to_i

    validation_arry.each do |zero|
      if zero == 0
        validated = false
        @errors << 'A value was 0'
      end
    end

    if @ballistic_skill == 1 || @ballistic_skill >= 7
      validated = false
      @errors << 'Ballistc skill is invalid'
    end

  end
end
