class InputsController < ApplicationController
  require 'gchart'
  require 'battleround.rb'
  require 'validation.rb'
  include BattleRound
  include Validation

  def index
    @battle = {}
  end

  def create
    @validated = true
    validation(battle_params)
    if @validated == true
      @total_rounds = []
      @times_run = params["times_run"].to_i
      while @times_run > 0
        battle(battle_params)
        @times_run -=1
        @total_rounds << @round
      end

      aggregation(@total_rounds)

      render "show"
    else
      render "show"
      @errors
    end
  end

  private

  def battle_params
    params.permit(
      :attack_models,
      :shots,
      :d3,
      :d6,
      :ballistic_skill,
      :weapon_strength,
      :damage,
      :d3_damage,
      :d6_damage,
      :ap_value,
      :defend_models,
      :toughness,
      :wounds,
      :armour,
      :invulnerable,
      :plasma,
      :always_hit,
      :neg1_to_hit_attack,
      :neg1_to_hit_defend,
      :plus1_to_hit,
      :times_run,
      :reroll_hits,
      :reroll1_hits,
      :reroll_wounds,
      :reroll1_wounds,
      :authenticity_token,
      :utf8,
      :commit
    )
  end

  def aggregation(array)
    @final_hash = {}
    array.sort.each do |number|
      @final_hash.store(number,array.count(number))
    end
    # @final_array = @final_hash.to_a
    @final_hash.sort
    @highest = @final_hash.values.sort.last
  end
end
