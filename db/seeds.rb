# This file should ensure the existence of records required to run the application in
# every environment (production,development, test).
# The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with
# the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!(username: "白水 貴太",
             email: "sample@example.com",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "sample-#{n + 1}@example.com"
  password = "password"
  User.create!(username: name,
               email: email,
               password: password,
               password_confirmation: password)
end

# デフォルトの記念日データ
default_anniversaries = [
  { name: 'ニューボーン', date: Date.new(2020, 1, 1), description: '生後1ヶ月を祝う' },
  { name: 'お宮参り', date: Date.new(2020, 3, 3), description: '生後1ヶ月の健やかな成長を祈願する' },
  { name: '初節句', date: Date.new(2020, 5, 5), description: 'こどもの日、健やかな成長を願う' },
  { name: '七五三', date: Date.new(2020, 11, 15), description: '3歳と5歳と7歳の子供の成長を祝う' },
  { name: '入学式', date: Date.new(2021, 4, 6), description: '新しい学校生活のスタートを祝う' },
  # その他必要な記念日を追加
]

User.find_each do |user|
  default_anniversaries.each do |anniversary|
    user.child_anniversaries.find_or_create_by!(anniversary)
  end
end

10.times do |n|
  ChildPost.create!(
    content: "七五三の素敵なワンシーン #{n}",
    user_id: 1,
    child_anniversary_id: ChildAnniversary.pluck(:id).sample # ChildAnniversaryのIDの中からランダムに選ぶ
  )
end
