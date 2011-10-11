require File.dirname(__FILE__) + '/../spec_helper'

describe GameRule do
  it "should be valid" do
    GameRule.new.should be_valid
  end
end
