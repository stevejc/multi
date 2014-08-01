# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  owner_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  plan       :string(255)      default("gold"), not null
#  phone      :string(255)
#  email      :string(255)
#  address    :text
#  time_zone  :string(255)
#

FactoryGirl.define do
  factory :account do
    association :owner, factory: :user
    name "Account One"
  end
end
