require 'rails_helper'

RSpec.describe "コメント機能", type: :request do
  let!(:user) { create(:user) }
  let!(:child_post) { create(:child_post) }
  let!(:comment) { create(:comment, user_id: user.id, child_post: child_post) }

  context "コメントの登録" do
    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "有効な内容のコメントが登録できること" do
        expect {
          post comments_path, params: { child_post_id: child_post.id,
                                        comment: { content: "最高です！" } }
        }.to change(child_post.comments, :count).by(1)
      end

      it "無効な内容のコメントが登録できないこと" do
        expect {
          post comments_path, params: { child_post_id: child_post.id,
                                        comment: { content: "" } }
        }.not_to change(child_post.comments, :count)
      end
    end
    end

    context "ログインしていない場合" do
      it "コメントは登録できず、ログインページへリダイレクトすること" do
        expect {
          post comments_path, params: { child_post_id: child_post.id,
                                        comment: { content: "最高です！" } }
        }.not_to change(child_post.comments, :count)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context "コメントの削除" do
    context "ログインしている場合" do
      context "コメントを作成したユーザーである場合" do
        it "コメントの削除ができること" do
          sign_in user
          expect {
            delete comment_path(comment)
          }.to change(child_post.comments, :count).by(-1)
        end
      end

      context "コメントを作成したユーザーでない場合" do
        it "コメントの削除はできないこと" do
          sign_in other_user
            expect {
            delete comment_path(comment)
          }.not_to change(child_post.comments, :count)
          end
        end
      end
    end

    context "ログインしていない場合" do
      it "コメントの削除はできず、ログインページへリダイレクトすること" do
        expect {
          delete comment_path(comment)
        }.not_to change(child_post.comments, :count)
      end
    end
  end
end