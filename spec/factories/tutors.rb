FactoryGirl.define do

  factory :tutor do
    sequence(:name) { |n| "Name#{n}" }
    sequence(:qualification) { |n| "Qualification#{n}" }
  end
end
