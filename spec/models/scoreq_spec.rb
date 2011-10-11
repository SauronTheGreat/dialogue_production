require File.dirname(__FILE__) + '/../spec_helper'

describe Scoreq do
  it "should be valid" do
    Scoreq.new.should be_valid
  end
end
