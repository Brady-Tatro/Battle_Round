module ToWound

  def to_wound
    if @hits > 0
      @wounds = roll(@hits)
      rerolled_wounds = 0
      if @weapon_strength >= @toughness * 2
        if @battle_data["reroll1_wounds"] == "1"
          @wounds.each do |ones|
            if ones == 1
              rerolled_wounds += 1
            end
          end
          @wounds << roll(reroll_wounds)
        elsif @battle_data["reroll_wounds"] == "1"
          @wounds.each do |misses|
            if misses < 2
              reroll_wounds += 1
            end
          end
          @wounds << roll(reroll_wounds)
        end
        @wounds.delete_if { |wound| wound < 2 }
      elsif @weapon_strength > @toughness
        if @battle_data["reroll1_wounds"] == "1"
          @wounds.each do |ones|
            if ones == 1
              rerolled_wounds += 1
            end
          end
          @wounds << roll(reroll_wounds)
        elsif @battle_data["reroll_wounds"] == "1"
          @wounds.each do |misses|
            if misses < 3
              reroll_wounds += 1
            end
          end
          @wounds << roll(reroll_wounds)
        end
        @wounds.delete_if { |wound| wound < 3 }
      elsif @weapon_strength == @toughness
        if @battle_data["reroll1_wounds"] == "1"
          @wounds.each do |ones|
            if ones == 1
              rerolled_wounds += 1
            end
          end
          @wounds << roll(reroll_wounds)
        elsif @battle_data["reroll_wounds"] == "1"
          @wounds.each do |misses|
            if misses < 4
              reroll_wounds += 1
            end
          end
          @wounds << roll(reroll_wounds)
        end
        @wounds.delete_if { |wound| wound < 4 }
      elsif @weapon_strength <= @toughness / 2
        if @battle_data["reroll1_wounds"] == "1"
          @wounds.each do |ones|
            if ones == 1
              rerolled_wounds += 1
            end
            @wounds << roll(reroll_wounds)
          end
        elsif @battle_data["reroll_wounds"] == "1"
          @wounds.each do |misses|
            if misses < 6
              reroll_wounds += 1
            end
          end
          @wounds << roll(reroll_wounds)
        end
        @wounds.delete_if { |wound| wound < 6 }
      elsif @weapon_strength < @toughness
        if @battle_data["reroll1_wounds"] == "1"
          @wounds.each do |ones|
            if ones == 1
              rerolled_wounds += 1
            end
            @wounds << roll(reroll_wounds)
          end
        elsif @battle_data["reroll_wounds"] == "1"
          @wounds.each do |misses|
            if misses < 5
              reroll_wounds += 1
            end
          end
          @wounds << roll(reroll_wounds)
        end
        @wounds.delete_if { |wound| wound < 5 }
      end
      @rolled_wounds = @wounds.length
    end
  end

end
