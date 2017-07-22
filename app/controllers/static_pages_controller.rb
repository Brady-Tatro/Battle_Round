class StaticPagesController < ApplicationController

  def index
    @battle = {}
  end

  def create
    battle(battle_params)
  end

  private

  def battle_params
    params.permit(
      :attack_models,
      :shots,
      :ballistic_strength,
      :weapon_strength,
      :damage,
      :ap_value,
      :defend_models,
      :toughness,
      :wounds,
      :armour
    )
  end

  def battle(battle_data)
    @battle_data = battle_data
    round = 0
    while @battle_data.defend_models > 0 do
      to_hit
      to_wound
      saving_throw
      round += 1
      if round > 20
        break
      end
    end
    return round
  end

  def to_hit
    @shots = @battle_data.attack_models * @battle_data.shots
    @rolled_shots = roll(@shots)
    @rolled_shots.delete_if { |hit| hit < @battle_data.ballistic_strength }
    @hits = @rolled_shots.length
    end
  end

  def to_wound
    if @hits > 0
      @wounds = roll(@hits)
      if @battle_data.strength >= @battle_data.toughness * 2
        @wounds.delete_if { |wound| wound < 2 }
      elsif @battle_data.strength > @battle_data.toughness
        @wounds.delete_if { |wound| wound < 3 }
      elsif @battle_data.strength == battle_data.toughness
        @wounds.delete_if { |wound| wound < 4 }
      elsif @battle_data.strength / 2 <= battle_data.toughness
        @wounds.delete_if { |wound| wound < 6 }
      elsif @battle_data.strength < battle_data.toughness
        @wounds.delete_if { |wound| wound < 5 }
      else
        "error"
      end
    end
    return @wounds.length
  end

  def saving_throw
    if @wounds > 0
      @saved = roll(@wounds)
      @original = @saved.length
      @saved.delete_if { |save| save < @battle_data.armour }
      if @battle_data.ap_value > 0
        @saved.delete_if { |save| save - @battle_data.ap_value < @battle_data.armour  }
      end
    end
    @damaged = @original - @saved.length
    while @damage > 0
      current_wounds = 0
      current_wounds += @battle_data.damage
        if current_wounds >= @battle_data.wounds
          @battle_data.defend_models -=1
          current_wounds = 0
        end
    end
    return @battle_data.defend_models
  end

  def roll(num)
    result = []
    num.times do
      result << rand(6) + 1
    end
    return result
  end
end
