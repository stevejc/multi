FactoryGirl.define do
  factory :client do
    association :account
    name "Test Client"
  end
end