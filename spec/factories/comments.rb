FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "楽しそうでなにより" }
    association :child_post
  end
end