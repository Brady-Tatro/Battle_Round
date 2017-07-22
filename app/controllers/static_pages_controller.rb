class StaticPagesController < ApplicationController

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
    render "index"
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
      :armour,
      :times_run
    )
  end

  def battle(battle_data)
    @battle_data = battle_data
    @round = 0
    while @battle_data["defend_models"].to_i > 0 do
      to_hit
      to_wound
      saving_throw
      @round += 1
    end
    return @round
  end

  def to_hit
    @shots = @battle_data["attack_models"].to_i * @battle_data["shots"].to_i
    @rolled_shots = roll(@shots)
    @rolled_shots.delete_if { |hit| hit < @battle_data["ballistic_strength"].to_i }
    @hits = @rolled_shots.length
  end

  def to_wound
    if @hits > 0
      @wounds = roll(@hits)
      if @battle_data["strength"].to_i >= @battle_data["toughness"].to_i * 2
        @wounds.delete_if { |wound| wound < 2 }
      elsif @battle_data["strength"].to_i > @battle_data["toughness"].to_i
        @wounds.delete_if { |wound| wound < 3 }
      elsif @battle_data["strength"].to_i == @battle_data["toughness"].to_i
        @wounds.delete_if { |wound| wound < 4 }
      elsif @battle_data["strength"].to_i / 2 <= @battle_data["toughness"].to_i
        @wounds.delete_if { |wound| wound < 6 }
      elsif @battle_data["strength"].to_i < @battle_data["toughness"].to_i
        @wounds.delete_if { |wound| wound < 5 }
      else
        "error"
      end
    end
    return @wounds.length
  end

  def saving_throw
    if @wounds.length > 0
      @saved = roll(@wounds.length)
      @original = @saved.length
      @saved.delete_if { |save| save < @battle_data["armour"].to_i }
      if @battle_data["ap_value"].to_i > 0
        @saved.delete_if { |save| save - @battle_data["ap_value"].to_i < @battle_data["armour"].to_i  }
      end
      if @saved.nil?
        @damaged = @original
      else
        @damaged = @original - @saved.length
      end
      while @damaged > 0
        current_wounds = 0
        current_wounds += @battle_data["damage"].to_i
          if current_wounds >= @battle_data["wounds"].to_i
            @battle_data["defend_models"] = @battle_data["defend_models"].to_i - 1
            current_wounds = 0
          end
          @damaged -= 1
      end
    end
    return @battle_data["defend_models"].to_i
  end

  def roll(num)
    result = []
    num.times do
      result << rand(6) + 1
    end
    return result
  end
end
