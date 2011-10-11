require File.dirname(__FILE__) + '/../spec_helper'

describe Briefing do
  it "should be valid" do
    Briefing.new.should be_valid
  end
end
