class ShareArticleJob < ApplicationJob
  queue_as :default

  def perform(article_id:, from_user_id:, to_email:, message: nil)
    ShareMailer.invitation_to_read(
      article_id: article_id,
      from_user_id: from_user_id,
      to_email: to_email,
      message: message
    ).deliver_now
  end
end
