require "rails_helper"

RSpec.describe "ユーザーの削除", type: :request do
  let!(:admin_user) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:child_post) { create(:child_post, user: user) }

  context "管理者ユーザーの場合" do
    it "ユーザーを削除後、ユーザー一覧ページにリダイレクト" do
      sign_in admin_user
      expect do
        delete user_path(user)
      end.to change(User, :count).by(-1)
      redirect_to users_url
      follow_redirect!
      expect(response).to render_template('users/index')
    end
  end

  context "管理者以外のユーザーの場合" do
    it "自分のアカウントを削除できること" do
      sign_in user
      expect do
        delete user_path(user)
      end.to change(User, :count).by(-1)
      redirect_to root_url
    end

    it "自分以外のユーザーを削除しようとすると、トップページへリダイレクトすること" do
      sign_in user
      expect do
        delete user_path(other_user)
      end.not_to change(User, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログインページへリダイレクトすること" do
      expect do
        delete user_path(user)
      end.not_to change(User, :count)
      expect(response).to have_http_status "302"
      expect(response).to new_user_session_path
    end
  end

  context "記念日投稿が紐づくユーザーを削除した場合" do
    it "ユーザーと同時に紐づく料理も削除される" do
      sign_in user
      expect  do
        delete user_path(user)
      end.to change(ChildPost, :count).by(-1)
    end
  end

  context "記念日が紐づくユーザーを削除した場合" do
    it "ユーザーと同時に紐づく料理も削除される" do
      sign_in user
      expect  do
        delete user_path(user)
      end.to change(ChildAnniversary, :count).by(-1)
    end
  end
end
