require "rails_helper"
RSpec.describe "ユーザー登録", type: :request do
  before do
    get new_user_registration_path
  end

  it "正常なレスポンスを返すこと" do
    expect(response).to be_success
    expect(response).to have_http_status "200"
  end

  it "有効なユーザーで登録" do
    expect do
      post user_registration_path, params: {
        user: {
          username: "Example User",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password",
        },
      }
    end.to change(User, :count).by(1)
    redirect_to @user
    follow_redirect!
    expect(response).to render_template('static_pages/home')
  end

  it "無効なユーザーで登録" do
    expect do
      post user_registration_path, params: {
        user: {
          username: "",
          email: "user@example.com",
          password: "password",
          password_confirmation: "pass",
        },
      }
    end.not_to change(User, :count)
  end
end
