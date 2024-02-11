FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      sequence(:email) { |n| "example#{n}@example.com" }
      password { "foobar" }
      password_confirmation { "foobar" }
      profile { "はじめまして。料理初心者ですが、頑張ります！" }
    end
  end