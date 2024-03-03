require "rails_helper"

RSpec.describe "記念日個別ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:child_anniversary) { create(:child_anniversary, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      sign_in user
      get child_anniversary_path(child_anniversary)
      expect(response).to have_http_status "200"
      expect(response).to render_template('child_anniversaries/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get child_anniversary_path(child_anniversary)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end
  end
end
