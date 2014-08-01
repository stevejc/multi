# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  address    :text
#  account_id :integer
#  created_at :datetime
#  updated_at :datetime
#

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
