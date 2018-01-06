require 'rails_helper'
require 'moral.rb'

describe Moral do
  include Moral

  it { hippo.should == "hippo" }
end
