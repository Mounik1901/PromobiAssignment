FactoryGirl.define do

  factory :course do
    sequence(:name) { |n| "Title#{n}" }
    sequence(:duration) { |n| n }
    tutors {[FactoryGirl.create(:tutor), FactoryGirl.create(:tutor), FactoryGirl.create(:tutor)]}
  end

  factory :course_with_out_tutor, class: Course do
    sequence(:name) { |n| "Title#{n}" }
    sequence(:duration) { |n| n }
  end
end
