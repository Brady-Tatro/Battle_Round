class InputsController < ApplicationController
  require 'gchart'
  require 'battleround.rb'
  require 'validation.rb'
  include BattleRound
  include Validation

  def index
    @battle = Battle.new
  end

  def create
    @battle = Battle.new(battle_params)
    battle_results
    @battle.total_rounds = @total_rounds
    if @battle.save
      redirect_to action: "show", id: @battle.id
    else
      flash[:notice] = 'This Battle is invalid, please check to make sure all values have been filled out properly'
      redirect_to 
    end
  end

  def show
    @showing_result = Battle.find(params[:id])
    aggregation(@showing_result[:total_rounds])
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
      :leadership,
      :plasma,
      :sniper,
      :always_hit,
      :neg1_to_hit_attack,
      :neg1_to_hit_defend,
      :plus1_to_hit,
      :times_run,
      :reroll_hits,
      :reroll1_hits,
      :reroll_wounds,
      :reroll1_wounds
    )
  end

  def battle_results
    @total_rounds = []
    @times_run = params["times_run"].to_i
    while @times_run > 0
      battle(battle_params)
      @times_run -=1
      @total_rounds << @round
    end
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
