FactoryBot.define do
  factory :child_anniversary do
    sequence(:name) { |n| "Anniversary #{n}" }
    date { Date.today }
    description { "This is a description for the anniversary occurring on #{date}." }
    association :user
  end

  trait :anniversary_yesterday do
    created_at { 1.days.ago }
  end

  trait :anniversary_one_week_ago do
    created_at { 1.week.ago }
  end

  trait :anniversary_one_month_ago do
    created_at { 1.month.ago }
  end
end
