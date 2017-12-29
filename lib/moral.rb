module Moral

  def moral_test
    moral_result = @died_this_round + (rand(6) + 1)
    if moral_result > @leadership
      moral_result = moral_result - @leadership
      @defending_models = @defending_models - moral_result
    end
  end

end
