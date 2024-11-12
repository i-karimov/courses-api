FactoryBot.define do
  factory :course do
    title
    description { FFaker::Lorem.sentence(rand 10..20) }
    author
  end
end
