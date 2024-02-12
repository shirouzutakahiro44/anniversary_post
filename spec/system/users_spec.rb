require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  describe "ユーザー登録ページ" do
    before do
      visit new_user_registration_path
    end

    context "ページレイアウト" do
      it "「ユーザー登録」の文字列が存在することを確認" do
        expect(page).to have_content 'ユーザー登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title('ユーザー登録 - アニバポスト')
      end
    end

    context "ユーザー登録処理" do
      it "有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること" do
        fill_in "ユーザーネーム", with: "Example user"
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認用）", with: "password"
        click_button "アカウント登録"
        expect(page).to have_content("アカウント登録が完了しました。")
      end
    
      it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
        fill_in "ユーザーネーム", with: ""
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認用）", with: "pass"
        click_button "アカウント登録"
        expect(page).to have_content "ユーザー名を入力してください"
        expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
      end
    end
  end
  
  describe "プロフィールページ" do
    context "ページレイアウト" do
      before do
        visit user_path(user)
      end
  
      it "「プロフィール」の文字列が存在することを確認" do
        expect(page).to have_content 'プロフィール'
      end
  
      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title('ユーザー詳細 - アニバポスト')
      end
  
      it "ユーザー情報が表示されることを確認" do
        expect(page).to have_content user.name
        expect(page).to have_content user.profile
        expect(page).to have_content user.email
      end
    end
  end
end
