FactoryBot.define do
  factory :child_post do
    content { "みちの退職記念日位" }
    association :user
    created_at { Time.current }
  end

  trait :yesterday do
    created_at { 1.days.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end
end
