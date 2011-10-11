require File.dirname(__FILE__) + '/../spec_helper'

describe Rule do
  it "should be valid" do
    Rule.new.should be_valid
  end
end
