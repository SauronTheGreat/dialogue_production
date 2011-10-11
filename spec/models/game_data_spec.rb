require File.dirname(__FILE__) + '/../spec_helper'

describe GameData do
  it "should be valid" do
    GameData.new.should be_valid
  end
end
