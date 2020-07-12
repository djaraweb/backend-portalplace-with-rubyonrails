require "rails_helper"
require "byebug"

RSpec.describe "Posts", type: :request do

  describe "GET /posts" do
    before { get '/posts' }

    it "test 01: should return OK" do
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end

  end

  describe "with data in the DB" do
    let!(:posts) { create_list(:post, 10, published: true) }

    it "test 02: should return all the published posts" do
      get '/posts'
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(posts.size)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /posts/{id}" do
    
    it "test 03: should return 404 if post not exists" do
      get "/posts/#{0}"
      expect(response).to have_http_status(404)
    end

    let!(:post) { create(:post) }

    it "test 04: should return a post" do
      get "/posts/#{post.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to eq(post.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /posts" do
    let!(:user) { create(:user) }

    it "test 05: should create a post" do
      req_payload = {
        post: {
          title: "titulo",
          content: "content",
          published: false,
          user_id: user.id
        }
      }
      # POST HTTP
      post "/posts", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to_not be_nil
      expect(response).to have_http_status(:created)
    end

    it "test 06: should return error message on invalid post" do
      req_payload = {
        post: {
          # title: "titulo",
          content: "content",
          published: false,
          user_id: user.id
        }
      }
      # POST HTTP
      post "/posts", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /posts/{id}" do
    let!(:article) { create(:post) }

    it "test 07: should updated a post" do
      req_payload = {
        post: {
          title: "titulo",
          content: "content",
          published: true
        }
      }
      # PUT HTTP
      put "/posts/#{article.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["id"]).to eq(article.id)
      expect(response).to have_http_status(:ok)
    end

    it "test 07: should return error message on invalid post" do
      req_payload = {
        post: {
          title: nil,
          content: nil,
          published: false,
        }
      }
      # PUT HTTP
      put "/posts/#{article.id}", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload["error"]).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

end