require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "アニバポストの文字列があることを確認" do
        expect(page).to have_content 'アニバポスト'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title('HOME - アニバポスト')
      end

      context "こども記念日フィード", js: true do
        let!(:user) { create(:user) }
        let!(:child_post) { create(:child_post) }

        it "こども記念日写真のページネーションが表示されること" do
          sign_in(user)
          create_list(:child_post, 6, user: user)
          visit root_path
          expect(page).to have_content "こども記念日( #{user.child_post.count})"
          expect(page).to have_css "div.pagination"
          ChildPost.take(5).each do |d|
            expect(page).to have_link d.name
          end
        end

        it "こども記念日作成リンクが表示されること" do
          visit root_path
          expect(page).to have_link "記念日作成", href: new_anniversary_child_path
        end

        it "こども記念日削除後、フラッシュメッセージが表示されること" do
          visti root_path
          click_on "削除"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "記念日を削除しました"
        end
      end
    end
  end

  describe "ヘルプページ" do
    before do
      visit about_path
    end

    it 'アニバポストとは？の文字列が存在することを確認' do
      expect(page).to have_content 'アニバポストとは'
    end

    it '正しいタイトルが表示されることを確認' do
      expect(page).to have_title('アニバポストについて - アニバポスト')
    end
  end

  describe "利用規約" do
    before do
      visit use_of_terms_path
    end

    it '利用規約の文字列が存在することを確認' do
      expect(page).to have_content '利用規約'
    end

    it '正しいタイトルが表示されることを確認' do
      expect(page).to have_title('利用規約 - アニバポスト')
    end
  end
end
