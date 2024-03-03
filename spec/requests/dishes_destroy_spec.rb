require "rails_helper"

RSpec.describe "記念日の削除", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:child_anniversary) { create(:child_anniversary, user: user) }

  context "ログインしていて、自分の記念日を削除する場合" do
    it "処理が成功し、トップページにリダイレクトすること" do
      sign_in user
      expect {
        delete child_anniversary_path(child_anniversary)
      }.to change(ChildAnniversary, :count).by(-1)
      follow_redirect!
      expect(response).to render_template('static_pages/home')
    end
  end

  context "ログインしていて、他人の記念日を削除する場合" do
    it "処理が失敗し、トップページへリダイレクトすること" do
      sign_in other_user
      expect {
        delete child_anniversary_path(child_anniversary)
      }.not_to change(ChildAnniversary, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end

  context "ログインしていない場合" do
    it "ログインページへリダイレクトすること" do
      expect {
        delete child_anniversary_path(child_anniversary)
      }.not_to change(ChildAnniversary, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end