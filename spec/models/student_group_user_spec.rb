require File.dirname(__FILE__) + '/../spec_helper'

describe StudentGroupUser do
  it "should be valid" do
    StudentGroupUser.new.should be_valid
  end
end
