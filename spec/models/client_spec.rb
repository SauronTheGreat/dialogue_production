require File.dirname(__FILE__) + '/../spec_helper'

describe Client do
  it "should be valid" do
    Client.new.should be_valid
  end
end
