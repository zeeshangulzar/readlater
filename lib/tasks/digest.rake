namespace :digest do
  desc "Email each user their reading list from the past week"
  task weekly: :environment do
    User.where.not(confirmed_at: nil).find_each do |user|
      WeeklyDigestMailer.send_digest(user_id: user.id).deliver_now
    end
  end
end
