class ShareMailer < ApplicationMailer
  default from: "readlater@example.com"

  def invitation_to_read(article_id:, from_user_id:, to_email:, message: nil)
    @article = Article.find(article_id)
    @from_user = User.find(from_user_id)
    @to_email = to_email
    @message = message

    mail(
      to: to_email,
      subject: "#{@from_user.email} thought you'd like: #{@article.title}"
    )
  end
end
