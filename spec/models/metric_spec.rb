require File.dirname(__FILE__) + '/../spec_helper'

describe Metric do
  it "should be valid" do
    Metric.new.should be_valid
  end
end
