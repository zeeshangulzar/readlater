class ArticleSharesController < ApplicationController
  before_action :authenticate_user!

  def create
    article = current_user.articles.find(params[:article_id])

    ShareArticleJob.perform_later(
      article_id: article.id,
      from_user_id: current_user.id,
      to_email: params[:to_email],
      message: params[:message].presence
    )

    redirect_to article, notice: "Invitation queued for #{params[:to_email]}."
  end
end
