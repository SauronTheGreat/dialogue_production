require File.dirname(__FILE__) + '/../spec_helper'

describe PlayerScorecard do
  it "should be valid" do
    PlayerScorecard.new.should be_valid
  end
end
