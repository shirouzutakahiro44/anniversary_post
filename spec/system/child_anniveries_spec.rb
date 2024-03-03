require 'rails_helper'

RSpec.describe "ChildAnniversaries", type: :system do
  let!(:user) { create(:user) }
  let!(:child_anniversary){ create(:child_anniversary, user: user) }

  describe "記念日登録ページ" do
    before do
      sign_in user
      visit new_child_anniversary_path
    end

    context "ページレイアウト" do
      it "「記念日作成」の文字列が存在すること" do
        expect(page).to have_content '記念日作成'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('こども記念日登録-アニバポスト')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '記念日の名前'
        expect(page).to have_content '記念日の内容'
        expect(page).to have_content '記念日の日付'
      end
    end

    context "記念日登録処理" do
      it "有効な情報で記念日登録を行うと料理登録成功のフラッシュが表示されること" do
        fill_in "記念日の名前", with: "初めて喋った日"
        fill_in "記念日の内容", with: "初めて〇〇が名前を呼んでくれた"
        fill_in "記念日の日付", with: "2024/02/26"
        click_button "保存"
        expect(page).to have_content "記念日登録"
      end

      it "無効な情報で記念日登録を行うと記念日登録失敗のフラッシュが表示されること" do
        fill_in "記念日の名前", with: ""
        fill_in "記念日の内容", with: "初めて〇〇が名前を呼んでくれた"
        fill_in "記念日の日付", with: "2024/02/26"
        click_button "保存"
        expect(page).to have_content "記念日名を入力してください"
      end
    end
  end

  describe "記念日詳細ページ" do
    context "ページレイアウト" do
      before do
        sign_in user
        visit child_anniversary_path(child_anniversary)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{child_anniversary.name}")
      end

      it "記念日情報が表示されること" do
        expect(page).to have_content child_anniversary.name
        expect(page).to have_content child_anniversary.description
        expect(page).to have_content dish.date
      end
    end

    context "記念日の削除", js: true do
      it "削除成功のフラッシュが表示されること" do
        sign_in user
        visit child_anniversary_path(child_anniversary)
        within find('.change-child-anniversary')
          click_on '削除'
        end
      end
    end
  end

  describe "記念日編集ページ" do
    before do
      sign_in user
      visit child_anniversary_path(child_anniversary)
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("記念日の編集")
      end

      it "記念日情報が表示されること" do
        expect(page).to have_content '記念日の名前'
        expect(page).to have_content '記念日の内容'
        expect(page).to have_content '記念日の日付'
      end
    end

    context "記念日の更新処理" do
      it "有効な更新" do
        fill_in "記念日の名前", with: "編集:初めて喋った日"
        fill_in "記念日の内容", with: "編集:初めて〇〇が名前を呼んでくれた"
        fill_in "記念日の日付", with: "編集:2024/02/26"
        click_button "保存"
        expect(page).to have_content "記念日情報が更新されました"
        expect(child_anniversary.reload.name).to eq "編集:初めて喋った日"
        expect(child_anniversary.reload.description).to eq "編集:初めて〇〇が名前を呼んでくれた"
        expect(child_anniversary.reload.description).to eq "編集:2024/02/26" 
      end
        
      it "無効な更新" do
        fill_in "記念日の名前", with: ""
        click_button "保存"
        expect(page).to have_content "記念日を入力してください"
        expect(child_anniversary.reload.name).not_to eq ""
      end
    end

    context "記念日の削除", js: true do
      it "削除成功のフラッシュメッセージが表示されること" do
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '料理が削除されました'
      end
    end
  end
end