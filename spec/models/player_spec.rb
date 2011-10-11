require File.dirname(__FILE__) + '/../spec_helper'

describe Player do
  it "should be valid" do
    Player.new.should be_valid
  end
end
