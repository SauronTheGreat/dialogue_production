require File.dirname(__FILE__) + '/../spec_helper'

describe Email do
  it "should be valid" do
    Email.new.should be_valid
  end
end
