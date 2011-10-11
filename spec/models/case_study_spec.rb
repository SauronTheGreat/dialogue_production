require File.dirname(__FILE__) + '/../spec_helper'

describe CaseStudy do
  it "should be valid" do
    CaseStudy.new.should be_valid
  end
end
