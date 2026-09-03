class WeeklyDigestMailer < ApplicationMailer
  default from: "readlater@example.com"

  def send_digest(user_id:, since: 1.week.ago)
    @user = User.find(user_id)
    @articles = @user.articles.where("created_at >= ?", since).order(created_at: :desc)
    @since = since

    mail(
      to: @user.email,
      subject: "Your weekly reading list (#{@articles.size})"
    )
  end
end
