require File.dirname(__FILE__) + '/../spec_helper'

describe GameRole do
  it "should be valid" do
    GameRole.new.should be_valid
  end
end
