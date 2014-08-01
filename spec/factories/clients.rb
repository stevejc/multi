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

FactoryGirl.define do
  factory :client do
    association :account
    name "Test Client"
  end
end
