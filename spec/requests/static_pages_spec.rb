require 'rails_helper'

RSpec.describe "静的ページ", type: :request do
  describe "トップページ" do
    it "正常なレスポンスを返すこと" do
      get root_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "クックログとは？ページ" do
    it "正常なレスポンスを返すこと" do
      get about_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "利用規約ページ" do
    it "正常なレスポンスを返すこと" do
      get use_of_terms_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
end
