require "rails_helper"

RSpec.describe "記念日登録", type: :request do
  let!(:user){ create(:user) }
  let!(:child_post){ create(:child_post, user: user) }

  context "ログインしているユーザーの場合" do
    before do
      get new_anniversary_child_path
      sign_in user
    end

    context "フレンドリーフォロワーディング" do
      it "レスポンスが正常に表示されること" do
        expect(response).to redirect_to new_anniversary_child_path
      end
    end

    it "レスポンスが正常に表示される" do

      expect(response).to have_http_status "200"
      expect(response).to render_template('child_anniversary/new')
    end

    it "有効な記念日データが登録できること" do
      expect{
        post child_anniversaries_path, params: { child_anniversary: { name: "入学式",
                                                                      descriptin: "〇〇の小学校入学式"
                                                                      date: 2023/4/1} }
      }.to change(ChildAnniversary, count).by(1)
      follow_redirect!
      expect(response).to render_template('child_anniversaries/show')
    end

    it "有効な記念日データが登録できないこと" do
      expect{
        post child_anniversaries_path, params: { child_anniversary: { name: "",
                                                                      descriptin: "〇〇の小学校入学式"
                                                                      date: 2023/4/1} }
      }.not_to change(ChildAnniversary, count)
      expect(response).to render_template('child_anniversaries/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    get new_anniversary_child_path
    expect(response).to have_http_status "302"
    expect(response).to redirect_to sign_in_path
  end
end