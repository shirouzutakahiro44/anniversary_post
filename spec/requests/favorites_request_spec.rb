require 'rails_helper'

RSpec.describe "お気に入り登録機能", type: :request do
  let(:user) { create(:user) }
  let(:child_post) { create(:child_post) }

  context "お気に入り登録処理" do
    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "こども記念日のお気に入り登録ができること" do
        expect {
          post "/favorites/#{child_post.id}/create"
        }.to change(user.favorites, :count).by(1)
      end

      it "記念日のAjaxによるお気に入り登録ができること" do
        expect {
          post "/favorites/#{child_post.id}/create", xhr: true
        }.to change(user.favorites, :count).by(1)
      end

      it "記念日のお気に入り解除ができること" do
        user.favorite(child_post)
        expect {
          delete "/favorites/#{child_post.id}/destroy"
        }.to change(user.favorites, :count).by(-1)
      end

      it "記念日のAjaxによるお気に入り解除ができること" do
        user.favorite(child_post)
        expect {
          delete "/favorites/#{child_post.id}/destroy", xhr: true
        }.to change(user.favorites, :count).by(-1)
      end
    end

    context "ログインしていない場合" do
      it "お気に入り登録は実行できず、ログインページへリダイレクトすること" do
        expect {
          post "/favorites/#{child_post_.id}/create"
        }.not_to change(Favorite, :count)
        expect(response).to redirect_to new_user_session_path
      end

      it "お気に入り解除は実行できず、ログインページへリダイレクトすること" do
        expect {
          delete "/favorites/#{child_post_.id}/destroy"
        }.not_to change(Favorite, :count)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end