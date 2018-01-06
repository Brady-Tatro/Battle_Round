module Moral

  def moral_test
    moral_result = @died_this_round + d6
    if moral_result > @leadership
      moral_result = moral_result - @leadership
      @defending_models = @defending_models - moral_result
    end
  end

  def hippo
    "hippo"
  end

end
