module ToWound

  def to_wound
    if @hits > 0
      @wounds = roll(@hits)
      @combat_mortal = 0
      reroll_wounds = 0
      wound_target

        if @battle_data["reroll1_wounds"] == "1"
          @wounds.each do |ones|
            if ones == 1
              reroll_wounds += 1
            end
          end
          @wounds << roll(reroll_wounds)
        elsif @battle_data["reroll_wounds"] == "1"
          @wounds.each do |misses|
            if misses < @target
              reroll_wounds += 1
            end
          end
          @wounds << roll(reroll_wounds)
        end
        @wounds.flatten.delete_if { |wound| wound < @target }
        combat_mortal_wounds if @battle_data["sniper"] == "1"
      @rolled_wounds = @wounds.length
    end
  end

  def wound_target
    if @weapon_strength > @toughness * 2
      @target = 2
    elsif @weapon_strength > @toughness
      @target = 3
    elsif @weapon_strength == @toughness
      @target = 4
    elsif @weapon_strength < @toughness
      @target = 5
    else
      @target = 6
    end
      return @target
  end

  def combat_mortal_wounds
    @wounds.each do |sniper|
      if sniper == 6
        @combat_mortal += 1
      end
    end
    return @combat_mortal
  end

end
