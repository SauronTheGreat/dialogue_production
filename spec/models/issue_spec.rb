require File.dirname(__FILE__) + '/../spec_helper'

describe Issue do
  it "should be valid" do
    Issue.new.should be_valid
  end
end
