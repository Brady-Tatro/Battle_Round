class StaticPagesController < ApplicationController
  require 'gchart'

  def index
    @battle = {}
  end

  def create
    @total_rounds = []
    @times_run = params["times_run"].to_i
    while @times_run > 0
      battle(battle_params)
      @times_run -=1
      @total_rounds << @round
    end

    aggregation(@total_rounds)

    render "index"
  end

  private

  def battle_params
    params.permit(
      :attack_models,
      :shots,
      :ballistic_skill,
      :weapon_strength,
      :damage,
      :ap_value,
      :defend_models,
      :toughness,
      :wounds,
      :armour,
      :invulnerable,
      :neg1_to_hit,
      :plus1_to_hit,
      :times_run,
      :authenticity_token,
      :utf8,
      :commit
    )
  end

  def battle(battle_data)
    @battle_data = battle_data
    @round = 0
    @defending_models = @battle_data["defend_models"].to_i
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
    @shots = @battle_data["attack_models"].to_i * @battle_data["shots"].to_i
    @rolled_shots = roll(@shots)
    if @battle_data["plus1_to_hit"] == "1"
      @rolled_shots.delete_if { |hit| hit + 1 < @battle_data["ballistic_skill"].to_i }
    elsif @battle_data["neg1_to_hit"] == "1"
      @rolled_shots.delete_if { |hit| hit - 1 < @battle_data["ballistic_skill"].to_i }
    else
      @rolled_shots.delete_if { |hit| hit < @battle_data["ballistic_skill"].to_i }
    end
    @hits = @rolled_shots.length
  end

  def to_wound
    if @hits > 0
      @wounds = roll(@hits)
      if @battle_data["weapon_strength"].to_i >= @battle_data["toughness"].to_i * 2
        @wounds.delete_if { |wound| wound < 2 }
      elsif @battle_data["weapon_strength"].to_i > @battle_data["toughness"].to_i
        @wounds.delete_if { |wound| wound < 3 }
      elsif @battle_data["weapon_strength"].to_i == @battle_data["toughness"].to_i
        @wounds.delete_if { |wound| wound < 4 }
      elsif @battle_data["weapon_strength"].to_i <= @battle_data["toughness"].to_i / 2
        @wounds.delete_if { |wound| wound < 6 }
      elsif @battle_data["weapon_strength"].to_i < @battle_data["toughness"].to_i
        @wounds.delete_if { |wound| wound < 5 }
      end
    end
    @rolled_wounds = @wounds.length
  end

  def saving_throw
    if @rolled_wounds > 0
      @saved = roll(@rolled_wounds)
      @original = @saved.length
      @saved.delete_if { |save| save < @battle_data["armour"].to_i && @battle_data["invulnerable"].to_i }
      if @battle_data["ap_value"].to_i > 0
        if @battle_data["invulnerable"].to_i > @battle_data["armour"].to_i - @battle_data["ap_value"].to_i
          @saved.delete_if { |save| save < @battle_data["invulnerable"].to_i  }
        else
          @saved.delete_if { |save| save - @battle_data["ap_value"].to_i < @battle_data["armour"].to_i  }
        end
      end
      if @saved.nil?
        @damaged = @original
      else
        @damaged = @original - @saved.length
      end
      current_wounds = 0
      while @damaged > 0
        current_wounds += @battle_data["damage"].to_i
          if current_wounds >= @battle_data["wounds"].to_i
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

  def aggregation(array)
    @final_array = {}
    array.sort.each do |number|
      @final_array.store(number,array.count(number))
    end

    @final_array.values.sort

  end
end
