require 'spec_helper'

describe Client do

  it "has a valid factory" do
    expect(build(:client)).to be_valid
  end
  
  it "is invalid without a name" do
    expect(build(:client, name: nil)).to have(1).errors_on(:name)
  end
  
  it "is invalid without an account" do
    expect(build(:client, account: nil)).to have(1).errors_on(:account)
  end
end