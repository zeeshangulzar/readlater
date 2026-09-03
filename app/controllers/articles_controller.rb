class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = current_user.articles.recent
  end

  def show
  end

  def new
    @article = current_user.articles.new
  end

  def edit
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article, notice: "Article saved."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @article.destroy!
    redirect_to articles_path, notice: "Article removed.", status: :see_other
  end

  private

  def set_article
    @article = current_user.articles.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :url, :notes)
  end
end
