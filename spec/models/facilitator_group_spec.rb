require File.dirname(__FILE__) + '/../spec_helper'

describe FacilitatorGroup do
  it "should be valid" do
    FacilitatorGroup.new.should be_valid
  end
end
