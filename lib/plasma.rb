module Plasma

  def plasma_to_hit
    @models_to_shoot = @attacking_models
    @hits = 0

    while @models_to_shoot > 0
      @ones_rolled = false
      @rerolled_shots = [0]
      @rolled_shots = roll(@shots)
      rerolling
      one_checking_no_reroll
      accumilation
    end

  end

  def one_checking_no_reroll
    @rolled_shots.each do |check|
      if check == 1
        @ones_rolled = true
        break
      end
    end
    if @ones_rolled == true
      @models_to_shoot -= 1
      @ones_rolled = false
      @rolled_shots = [0]
    end
  end

  def one_checking_reroll
    @rerolled.each do |check|
      if check == 1
        @ones_rolled = true
        break
      end
    end
    if @ones_rolled == true
      @models_to_shoot -= 1
      @ones_rolled = false
      @rolled_shots = [0]
      @rerolled_shots = [0]
    end
  end

  def rerolling
    if @battle_data["reroll1_hits"] == 1
      @rolled_shots.each do |ones|
        if ones == 1
          @rerolled_shots += 1
        end
      end
    elsif @battle_data["reroll_hits"] == 1
      @rolled_shots.each do |misses|
        if misses < @ballistic_skill
          @rerolled_shots += 1
        end
      end
    end
    @rerolled = roll(@rerolled_shots)
    one_checking_reroll
  end

  def accumilation
    total_shots = (@rolled_shots << @rerolled_shots).flatten!
    total_shots.delete_if { |hit| hit < @ballistic_skill }
    @hits = total_shots.length
  end
end
