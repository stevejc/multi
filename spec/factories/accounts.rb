FactoryGirl.define do
  factory :account do
    association :owner, factory: :user
    name "Account One"
  end
end