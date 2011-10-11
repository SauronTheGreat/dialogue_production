require File.dirname(__FILE__) + '/../spec_helper'

describe OptionValue do
  it "should be valid" do
    OptionValue.new.should be_valid
  end
end
