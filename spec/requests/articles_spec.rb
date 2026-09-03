require "rails_helper"

RSpec.describe "/articles", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { { title: "A good post", url: "https://example.com/post", notes: "Read on the train." } }
  let(:invalid_attributes) { { title: "", url: "not-a-url" } }

  context "when signed out" do
    it "redirects the articles index to sign in" do
      get articles_url
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  context "when signed in" do
    before { sign_in user }

    describe "GET /index" do
      it "is successful" do
        create(:article, user: user)
        get articles_url
        expect(response).to be_successful
      end

      it "does not show articles from other users" do
        someone_else = create(:article, user: create(:user), title: "Not yours")
        get articles_url
        expect(response.body).not_to include("Not yours")
      end
    end

    describe "GET /new" do
      it "is successful" do
        get new_article_url
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      it "creates a new article scoped to the current user" do
        expect { post articles_url, params: { article: valid_attributes } }
          .to change(user.articles, :count).by(1)
        expect(response).to redirect_to(article_url(Article.last))
      end

      it "rejects invalid attributes" do
        expect { post articles_url, params: { article: invalid_attributes } }
          .not_to change(Article, :count)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested article" do
        article = create(:article, user: user)
        expect { delete article_url(article) }.to change(user.articles, :count).by(-1)
        expect(response).to redirect_to(articles_url)
      end

      it "cannot destroy another user's article" do
        theirs = create(:article, user: create(:user))
        expect { delete article_url(theirs) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
