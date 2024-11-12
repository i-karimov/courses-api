FactoryBot.define do
  sequence(:email) { |n| "person_#{n}@example.com" }
  sequence(:title) { |n| "Title #{n}" }
end
