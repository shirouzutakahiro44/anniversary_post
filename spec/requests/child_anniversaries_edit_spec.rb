require "rails_helper"

RSpec.describe "記念日編集ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user){ create(:user) }
  let!(:child_anniversary) { create(:child_anniversary, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること(+フレンドリーフォワーディング)" do
      get edit_child_anniversary_path(child_anniversary)
      sign_in user
      expect(response).to render_template('child_anniversaries/edit')
      patch child_anniversary(child_anniversary), params: { child_anniversary: { name: "素晴らしき日"
                                                                                 description: "大切な一日"
                                                                                 date: "2024/02/27"} }
      expect(response).to redirect_to child_anniversary_path(child_anniversary)
      follow_redirect!
      expect(response).to render_template('child_anniversaries/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get edit_child_anniversary_path(child_anniversary)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path

      patch child_anniversary_path(child_anniversary), params: { child_anniversary: { name: "素晴らしき日"
                                                                                      descriptin: "大切な1日"
                                                                                      date: "2024/02/27"} }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "ホーム画像にリダイレクトすること" do
      sign_in other_user
      get edit_child_anniversary_path(child_anniversary)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path

      patch child_anniversary_path(child_anniversary), params: { child_anniversary: { name: "素晴らしき日"
                                                                                      descriptin: "大切な1日"
                                                                                      date: "2024/02/27"} }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end