FactoryBot.define do
  factory :favorite do
    association :child_post
    association :user
  end
end
