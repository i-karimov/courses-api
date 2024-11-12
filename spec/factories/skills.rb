FactoryBot.define do
  factory :skill do
    name { FFaker::Job.title }
    description { FFaker::Lorem.sentence(5) }
  end
end
