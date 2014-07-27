FactoryGirl.define do
  factory :user do
    email "john@example.com"
    password "pw"
    password_confirmation "pw"
  end
end