require File.dirname(__FILE__) + '/../spec_helper'

describe PlayerScore do
  it "should be valid" do
    PlayerScore.new.should be_valid
  end
end
