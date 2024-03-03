require 'rails_helper'

RSpec.describe "ChildAnniversaries", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/child_anniversaries/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/child_anniversaries/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/child_anniversaries/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/child_anniversaries/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/child_anniversaries/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/child_anniversaries/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/child_anniversaries/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
