require File.dirname(__FILE__) + '/../spec_helper'

describe RolePlayer do
  it "should be valid" do
    RolePlayer.new.should be_valid
  end
end
