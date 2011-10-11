require File.dirname(__FILE__) + '/../spec_helper'

describe Offer do
  it "should be valid" do
    Offer.new.should be_valid
  end
end
