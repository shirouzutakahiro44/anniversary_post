require 'rails_helper'

RSpec.describe ChildPost, type: :model do
  let!(:child_post_yesterday){ create(:child_post, :yesterday) }
  let!(:child_post_one_week_ago){ create(:child_post, :one_week_ago) }
  let!(:child_post_one_month_ago){ create(:child_post, :one_month_ago) }
  let!(:child_post){ create(:child_post) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(child_post).to be_valid
    end

    it "内容がなければ無効になること" do
      child_post = build(:child_post, content: nil)
      child_post.valid?
      expect(child_post.errors[:content]).to include("を入力してください")
    end

    it "内容が17文字以内であること" do
      child_post = build(:child_post, content: "あ" * 18)
      child_post.valid?
      expect(child_post.errors[:content]).to include("は17文字以内で入力してください")
    end
  end

  context "並び順" do
    it "最も最近の投稿が最初の投稿になっていること" do
      expect(:child_post).to eq  ChildPost.first
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
