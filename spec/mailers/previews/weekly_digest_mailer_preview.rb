# Preview all emails at http://localhost:3000/rails/mailers/weekly_digest_mailer
class WeeklyDigestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/weekly_digest_mailer/send_digest
  def send_digest
    WeeklyDigestMailer.send_digest
  end

end
