require File.dirname(__FILE__) + '/../spec_helper'

describe Planq do
  it "should be valid" do
    Planq.new.should be_valid
  end
end
