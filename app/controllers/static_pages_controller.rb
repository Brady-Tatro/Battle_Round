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
    while @battle_data.defend_models > 0 do
      to_hit
      to_wound
      saving_throw
    end
  #   X units fire Y shots a piece
  #   Ballistic strength = for every roll higher or equal than this number, it's a hit
  #
  #   Wounding....
  #   if a hit:
  #     if weapon strgnth's equal to defending toughness, 4 to wound.
  #     elsif greater than, but not double = 3 to wound
  #     elsif double or higher = 2 to wound
  #       if you're 1 below toughness, 5 to wound
  #         if you're double below toughness, 6 to wound
  #
  #
  # To see if wounds stick, check armour value
  #   if armour is X, you need a X or higher to save.
  end
  def to_hit
    @shots = @battle_data.attack_models * @battle_data.shots
    @rolled_shots = roll(@shots)
    @rolled_shots.delete_if { |hit| hit < @battle_data.ballistic_strength }
    @hits = @rolled_shots.length
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
