require File.dirname(__FILE__) + '/../spec_helper'

describe EducatorCaseStudy do
  it "should be valid" do
    EducatorCaseStudy.new.should be_valid
  end
end
