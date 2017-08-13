module BattleRound
  require 'tohit.rb'
  require 'towound.rb'
  require 'savingthrow.rb'
  require 'plasma.rb'

  include ToHit
  include ToWound
  include SavingThrow
  include Plasma

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
    @hp = @battle_data["wounds"].to_i

    while @defending_models > 0 do
      if @battle_data["plasma"] == 1
        binding.pry
        plasma_to_hit
      else
        to_hit
      end
      to_wound
      saving_throw
      @round += 1
      if @battle_data["times_run"].to_i >= 10 && @round == 100
        break
      end
    end
    return @round
  end

  def roll(num)
    result = []
    num.times do
      result << rand(6) + 1
    end
    return result
  end

  def d3
    return rand(3) + 1
  end

  def d6
    return rand(6) + 1
  end
end
