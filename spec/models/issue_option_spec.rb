require File.dirname(__FILE__) + '/../spec_helper'

describe IssueOption do
  it "should be valid" do
    IssueOption.new.should be_valid
  end
end
