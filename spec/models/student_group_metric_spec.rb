require File.dirname(__FILE__) + '/../spec_helper'

describe StudentGroupMetric do
  it "should be valid" do
    StudentGroupMetric.new.should be_valid
  end
end
