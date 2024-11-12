FactoryBot.define do
  sequence(:email) { |n| "person_#{n}@example.com" }
end
