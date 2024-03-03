require 'rails_helper'

RSpec.describe ChildAnniversary, type: :model do
  let!(:child_anniversary_yesterday){ create(:child_anniversary, :anniversary_yesterday) }
  let!(:child_anniversary_one_week_ago){ create(:child_anniversary, :anniversary_one_week_ago) }
  let!(:child_anniversary_one_month_ago){ create(:child_anniversary, :anniversary_one_month_ago) }
  let!(:child_anniversary){ create(:child_anniversary) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(child_anniversary).to be_valid
    end

    it "記念日名がなければ無効になること" do
      child_post = build(:child_anniversary, name: nil)
      child_post.valid?
      expect(child_anniversary.errors[:name]).to include("を入力してください")
    end

    it "記念日内容がなければ無効になること" do
      child_post = build(:child_anniversary, description: nil)
      child_post.valid?
      expect(child_anniversary.errors[:description]).to include("を入力してください")
    end

    it "内容が100文字以内であること" do
      child_anniversary = build(:child_anniversary, description: "あ" * 101)
      child_anniversary.valid?
      expect(child_anniversary.errors[:description]).to include("は17文字以内で入力してください")
    end
  end

  context "並び順" do
    it "最も最近の投稿が最初の投稿になっていること" do
      expect(:child_anniversary).to eq  ChildAnniversary.first
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
