module SavingThrow

  def saving_throw
    if @rolled_wounds > 0
      @saved = roll(@rolled_wounds)
      @original = @saved.length
      @saved.delete_if { |save| save < @armour && @invulnerable }
      if @ap_value > 0
        if @invulnerable > @armour - @ap_value
          @saved.delete_if { |save| save < @invulnerable  }
        else
          @saved.delete_if { |save| save - @ap_value < @armour  }
        end
      end
      if @saved.nil?
        @unsaved_wounds = @original
      else
        @unsaved_wounds = @original - @saved.length
      end
      current_wounds = 0
      @died_this_round = 0
      while @unsaved_wounds > 0
        if @battle_data["d3_damage"] == "1"
          current_wounds += d3
        elsif @battle_data["d6_damage"] = "1"
          current_wounds += d6
        else
        current_wounds += @damage
        end
          if current_wounds >= @hp
            @defending_models -= 1
            @died_this_round += 1
            current_wounds = 0
          end
        @unsaved_wounds -= 1
      end
    end
  end

end
