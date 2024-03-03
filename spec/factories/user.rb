FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name(specifier: 5..8) }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    profile { "はじめまして。料理初心者ですが、頑張ります！" }

    trait :admin do
      admin { true }
    end
  end
end
