FactoryGirl.define do
  factory :user do
    first_name "John"
    sequence(:last_name) { |n| "Doe#{n}" }
    email {"#{first_name}.#{last_name}@example.com".downcase }
    password "janedoe123"
    sequence(:mobile_number) { |n| "945555332#{n}" }
    created_at Time.now - 1.day
    updated_at Time.now - 1.day
  end
end
