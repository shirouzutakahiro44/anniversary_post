require 'rails_helper'

RSpec.describe "ユーザーフォロー機能", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  context "ログインしている場合" do
    before do
      sign_in user
    end

    it "ユーザーのフォローができること" do
      expect do
        post relationships_path, params: { followed_id: other_user.id }
      end.to change(user.following, :count).by(1)
    end

    it "ユーザーのAjaxによるフォローができること" do
      expect do
        post relationships_path, xhr: true, params: { followed_id: other_user.id }
      end.to change(user.following, :count).by(1)
    end

    it "ユーザーのアンフォローができること" do
      user.follow(other_user)
      relationship = user.active_relationships.find_by(followed_id: other_user.id)
      expect do
        delete relationship_path(relationship)
      end.to change(user.following, :count).by(-1)
    end

    it "ユーザーのAjaxによるアンフォローができること" do
      user.follow(other_user)
      relationship = user.active_relationships.find_by(followed_id: other_user.id)
      expect do
        delete relationship_path(relationship), xhr: true
      end.to change(user.following, :count).by(-1)
    end
  end

  context "ログインしていない場合" do
    it "followingページへ飛ぶとログインページへリダイレクトすること" do
      get following_user_path(user)
      expect(response).to redirect_to login_path
    end

    it "followersページへ飛ぶとログインページへリダイレクトすること" do
      get followers_user_path(user)
      expect(response).to redirect_to login_path
    end

    it "createアクションは実行できず、ログインページへリダイレクトすること" do
      expect do
        post relationships_path
      end.not_to change(Relationship, :count)
      expect(response).to redirect_to login_path
    end

    it "destroyアクションは実行できず、ログインページへリダイレクトすること" do
      expect do
        delete relationship_path(user)
      end.not_to change(Relationship, :count)
      expect(response).to redirect_to login_path
    end
  end
end
