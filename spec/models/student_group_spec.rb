require File.dirname(__FILE__) + '/../spec_helper'

describe StudentGroup do
  it "should be valid" do
    StudentGroup.new.should be_valid
  end
end
